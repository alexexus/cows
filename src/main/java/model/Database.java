package model;

import utils.Helper;

import javax.servlet.ServletContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class Database {

    private String dbUrl;       // строка подключения к базе данных
    private String dbUserName;  // имя пользователя базы данных
    private String dbPassword;  // пароль пользователя базы данных

    private static Logger logger = Logger.getLogger(Database.class.getName());

    public void init(ServletContext context) {
        // Чтение параметров контекста сервлета
        dbUrl = context.getInitParameter("dbUrl");
        dbUserName = context.getInitParameter("dbUserName");
        dbPassword = context.getInitParameter("dbPassword");
    }

    public void init(String dbUrl, String dbUserName, String dbPassword) {
        this.dbUrl = dbUrl;
        this.dbUserName = dbUserName;
        this.dbPassword = dbPassword;
    }

    public User login(String userName, String password) {
        String sql = "SELECT * FROM users WHERE user_name = ? AND password = ?";
        User user = null;
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, userName);
            st.setString(2, Helper.getMD5Hash(password));
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getLong("id"));
                    user.setFirstName(rs.getString("first_name"));
                    user.setLastName(rs.getString("last_name"));
                    user.setUserName(rs.getString("user_name"));
                    user.setPassword(rs.getString("password"));
                }
            } catch (SQLException ex) {
                throw ex;
            }
        } catch (Exception ex) {
            user = null;
            logger.severe(ex.getMessage());
        }
        return user;
    }

    public User register(User user) {
        String sql = "INSERT INTO users (first_name, last_name, user_name, password) values (?, ?, ?, ?);";
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);
             PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            st.setString(1, user.getFirstName());
            st.setString(2, user.getLastName());
            st.setString(3, user.getUserName());
            st.setString(4, Helper.getMD5Hash(user.getPassword()));
            if (st.executeUpdate() == 1) {
                try (ResultSet rs = st.getGeneratedKeys()) {
                    rs.next();
                    user.setId(rs.getLong(1));
                } catch (SQLException ex) {
                    throw ex;
                }
            } else {
                user = null;
            }
        } catch (Exception ex) {
            user = null;
            logger.severe(ex.getMessage());
        }
        return user;
    }

    public List<Rating> getRating() {
        String sql = "SELECT u.user_name, AVG(g.attempts * 1.0) AS avg_attempts, COUNT(*) AS games_count " +
                "FROM users u, games g " +
                "WHERE u.id = g.user_id " +
                "GROUP BY u.id, u.user_name " +
                "ORDER BY avg_attempts, u.user_name;";
        List<Rating> rating = new ArrayList<Rating>();
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);
             PreparedStatement st = conn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Rating item = new Rating();
                item.setUserName(rs.getString("user_name"));
                item.setAvgAttempts(rs.getDouble("avg_attempts"));
                item.setGamesCount(rs.getInt("games_count"));
                rating.add(item);
            }
        } catch (SQLException ex) {
            rating = null;
            logger.severe(ex.getMessage());
        }
        return rating;
    }

    public void addGame(User user, int attempts) {
        String sql = "INSERT INTO games (user_id, attempts) VALUES (?, ?);";
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setLong(1, user.getId());
            st.setInt(2, attempts);
            st.executeUpdate();
        } catch (SQLException ex) {
            logger.severe(ex.getMessage());
        }
    }
}
