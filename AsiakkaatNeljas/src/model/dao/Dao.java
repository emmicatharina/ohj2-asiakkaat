package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Asiakas;

public class Dao {
    private Connection con = null;
    private ResultSet rs = null;
    private PreparedStatement stmtPrep = null;
    private String sql;
    private String db = "Myynti.sqlite";

    private Connection yhdista() {
        Connection con = null;
        String path = System.getProperty("catalina.base");
        path = path.substring(0, path.indexOf(".metadata")).replace("\\", "/");
        String url = "jdbc:sqlite:" + path + db;
        try {
            Class.forName("org.sqlite.JDBC");
            con = DriverManager.getConnection(url);
            System.out.println("Yhteys avattu.");
        } catch (Exception e) {
            System.out.println("Yhteyden avaus epäonnistui.");
            e.printStackTrace();
        }
        return con;
    }

    public ArrayList<Asiakas> listaaKaikki() {
        ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>();
        sql = "SELECT * FROM asiakkaat";
        try {
            con = yhdista();
            if (con != null) {
                stmtPrep = con.prepareStatement(sql);
                rs = stmtPrep.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        Asiakas asiakas = new Asiakas();
                        asiakas.setEtunimi(rs.getString(2));
                        asiakas.setSukunimi(rs.getString(3));
                        asiakas.setPuhelin(rs.getString(4));
                        asiakas.setSposti(rs.getString(5));
                        asiakkaat.add(asiakas);
                    }
                }
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return asiakkaat;
    }

    public ArrayList<Asiakas> listaaKaikki(String hakusana) {
        ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>();
        sql = "SELECT * FROM asiakkaat WHERE etunimi LIKE ? or sukunimi LIKE ? or puhelin LIKE ? or sposti LIKE ?";
        try {
            con = yhdista();
            if (con != null) {
                stmtPrep = con.prepareStatement(sql);
                stmtPrep.setString(1, "%" + hakusana + "%");
                stmtPrep.setString(2, "%" + hakusana + "%");
                stmtPrep.setString(3, "%" + hakusana + "%");
                rs = stmtPrep.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        Asiakas asiakas = new Asiakas();
                        asiakas.setEtunimi(rs.getString(2));
                        asiakas.setSukunimi(rs.getString(3));
                        asiakas.setPuhelin(rs.getString(4));
                        asiakas.setSposti(rs.getString(5));
                        asiakkaat.add(asiakas);
                    }
                }
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return asiakkaat;
    }
}
