package com.lostfound.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.lostfound.model.Item;
import com.lostfound.util.DBConnection;

public class ItemDAO {

    public int addItem(Item item) {
        String sql = "INSERT INTO items (user_id, type, title, description, category, location, date_reported, status) VALUES (?, ?, ?, ?, ?, ?, ?, 'open')";
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, item.getUserId());
            ps.setString(2, item.getType());
            ps.setString(3, item.getTitle());
            ps.setString(4, item.getDescription());
            ps.setString(5, item.getCategory());
            ps.setString(6, item.getLocation());
            ps.setDate(7, item.getDateReported());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(con);
        }
        return -1;
    }

    public boolean addItemImage(int itemId, String imagePath) {
        String sql = "INSERT INTO item_images (item_id, image_path) VALUES (?, ?)";
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, itemId);
            ps.setString(2, imagePath);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.closeConnection(con);
        }
    }

    public List<Item> getAllItems(String type, String category, String keyword) {
        List<Item> items = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT i.*, u.name as reporter_name, u.email as reporter_email, u.phone as reporter_phone, " +
            "(SELECT image_path FROM item_images WHERE item_id = i.item_id LIMIT 1) as image_path " +
            "FROM items i JOIN users u ON i.user_id = u.user_id WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();

        if (type != null && !type.isEmpty() && !type.equals("all")) {
            sql.append(" AND i.type = ?");
            params.add(type);
        }
        if (category != null && !category.isEmpty() && !category.equals("all")) {
            sql.append(" AND i.category = ?");
            params.add(category);
        }
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (i.title LIKE ? OR i.description LIKE ? OR i.location LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        sql.append(" ORDER BY i.created_at DESC");

        Connection con = null;
        try {
            con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                items.add(mapItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(con);
        }
        return items;
    }

    public Item getItemById(int itemId) {
        String sql = "SELECT i.*, u.name as reporter_name, u.email as reporter_email, u.phone as reporter_phone, " +
            "(SELECT image_path FROM item_images WHERE item_id = i.item_id LIMIT 1) as image_path " +
            "FROM items i JOIN users u ON i.user_id = u.user_id WHERE i.item_id = ?";
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, itemId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapItem(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(con);
        }
        return null;
    }

    public List<Item> getItemsByUser(int userId) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT i.*, u.name as reporter_name, u.email as reporter_email, u.phone as reporter_phone, " +
            "(SELECT image_path FROM item_images WHERE item_id = i.item_id LIMIT 1) as image_path " +
            "FROM items i JOIN users u ON i.user_id = u.user_id WHERE i.user_id = ? ORDER BY i.created_at DESC";
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) items.add(mapItem(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(con);
        }
        return items;
    }

    public boolean updateItemStatus(int itemId, String status) {
        String sql = "UPDATE items SET status = ? WHERE item_id = ?";
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, itemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.closeConnection(con);
        }
    }

    public boolean deleteItem(int itemId) {
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            // Delete claims first
            PreparedStatement ps1 = con.prepareStatement("DELETE FROM claims WHERE item_id = ?");
            ps1.setInt(1, itemId);
            ps1.executeUpdate();
            // Delete images
            PreparedStatement ps2 = con.prepareStatement("DELETE FROM item_images WHERE item_id = ?");
            ps2.setInt(1, itemId);
            ps2.executeUpdate();
            // Delete item
            PreparedStatement ps3 = con.prepareStatement("DELETE FROM items WHERE item_id = ?");
            ps3.setInt(1, itemId);
            return ps3.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.closeConnection(con);
        }
    }

    public List<Item> getItemsByDateRange(java.sql.Date fromDate, java.sql.Date toDate) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT i.*, u.name as reporter_name, u.email as reporter_email, u.phone as reporter_phone, " +
            "(SELECT image_path FROM item_images WHERE item_id = i.item_id LIMIT 1) as image_path " +
            "FROM items i JOIN users u ON i.user_id = u.user_id " +
            "WHERE i.date_reported BETWEEN ? AND ? " +
            "ORDER BY i.date_reported ASC";
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDate(1, fromDate);
            ps.setDate(2, toDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) items.add(mapItem(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(con);
        }
        return items;
    }

    public int getTotalItems() {
        return getCount("SELECT COUNT(*) FROM items");
    }

    public int getOpenItems() {
        return getCount("SELECT COUNT(*) FROM items WHERE status = 'open'");
    }

    public int getResolvedItems() {
        return getCount("SELECT COUNT(*) FROM items WHERE status = 'resolved'");
    }

    public int getLostItemCount() {
        return getCount("SELECT COUNT(*) FROM items WHERE type = 'lost'");
    }

    public int getFoundItemCount() {
        return getCount("SELECT COUNT(*) FROM items WHERE type = 'found'");
    }

    private int getCount(String sql) {
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(con);
        }
        return 0;
    }

    private Item mapItem(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setItemId(rs.getInt("item_id"));
        item.setUserId(rs.getInt("user_id"));
        item.setType(rs.getString("type"));
        item.setTitle(rs.getString("title"));
        item.setDescription(rs.getString("description"));
        item.setCategory(rs.getString("category"));
        item.setLocation(rs.getString("location"));
        item.setDateReported(rs.getDate("date_reported"));
        item.setStatus(rs.getString("status"));
        item.setCreatedAt(rs.getTimestamp("created_at"));
        item.setImagePath(rs.getString("image_path"));
        item.setReporterName(rs.getString("reporter_name"));
        item.setReporterEmail(rs.getString("reporter_email"));
        item.setReporterPhone(rs.getString("reporter_phone"));
        return item;
    }
}
