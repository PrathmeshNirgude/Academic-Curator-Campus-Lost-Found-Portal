package com.lostfound.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.lostfound.model.Claim;
import com.lostfound.util.DBConnection;

public class ClaimDAO {

    public boolean addClaim(Claim claim) {
        String sql = "INSERT INTO claims (item_id, claimant_id, proof_description, status) VALUES (?, ?, ?, 'pending')";
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, claim.getItemId());
            ps.setInt(2, claim.getClaimantId());
            ps.setString(3, claim.getProofDescription());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.closeConnection(con);
        }
    }

    public boolean alreadyClaimed(int itemId, int userId) {
        String sql = "SELECT claim_id FROM claims WHERE item_id = ? AND claimant_id = ?";
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, itemId);
            ps.setInt(2, userId);
            return ps.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.closeConnection(con);
        }
    }

    public List<Claim> getClaimsByItem(int itemId) {
        List<Claim> claims = new ArrayList<>();
        String sql = "SELECT c.*, u.name as claimant_name, u.email as claimant_email, u.phone as claimant_phone, " +
                     "i.title as item_title, i.type as item_type FROM claims c " +
                     "JOIN users u ON c.claimant_id = u.user_id " +
                     "JOIN items i ON c.item_id = i.item_id WHERE c.item_id = ? ORDER BY c.claimed_at DESC";
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, itemId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) claims.add(mapClaim(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(con);
        }
        return claims;
    }

    public List<Claim> getAllClaims() {
        List<Claim> claims = new ArrayList<>();
        String sql = "SELECT c.*, u.name as claimant_name, u.email as claimant_email, u.phone as claimant_phone, " +
                     "i.title as item_title, i.type as item_type FROM claims c " +
                     "JOIN users u ON c.claimant_id = u.user_id " +
                     "JOIN items i ON c.item_id = i.item_id ORDER BY c.claimed_at DESC";
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) claims.add(mapClaim(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(con);
        }
        return claims;
    }

    public boolean updateClaimStatus(int claimId, String status) {
        String sql = "UPDATE claims SET status = ? WHERE claim_id = ?";
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, claimId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.closeConnection(con);
        }
    }

    public int getPendingClaimCount() {
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM claims WHERE status = 'pending'");
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(con);
        }
        return 0;
    }

    public int getTotalClaimCount() {
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM claims");
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(con);
        }
        return 0;
    }

    private Claim mapClaim(ResultSet rs) throws SQLException {
        Claim c = new Claim();
        c.setClaimId(rs.getInt("claim_id"));
        c.setItemId(rs.getInt("item_id"));
        c.setClaimantId(rs.getInt("claimant_id"));
        c.setProofDescription(rs.getString("proof_description"));
        c.setStatus(rs.getString("status"));
        c.setClaimedAt(rs.getTimestamp("claimed_at"));
        c.setClaimantName(rs.getString("claimant_name"));
        c.setClaimantEmail(rs.getString("claimant_email"));
        c.setClaimantPhone(rs.getString("claimant_phone"));
        c.setItemTitle(rs.getString("item_title"));
        c.setItemType(rs.getString("item_type"));
        return c;
    }
}
