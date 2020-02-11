/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author cgpc2
 */
public class GestorBasesDeDatos {
    private static final String URL = "jdbc:postgresql://localhost/BBDDTiendaPECL3";
    private static String USER;
    private static String PASSWORD;
    
    private static Connection conn;
    
    public static void connect(String u, String passw) {
        try {
            USER = u;
            PASSWORD = passw;
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            JOptionPane.showMessageDialog(null, "Usuario "+USER+" conectado");
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage());
        }
    }
    public static void disconnect() {
        try {
            conn.close();
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }
    }
    public static boolean isConnected() {
        return conn != null;
    }
    public static Connection getConnection() {
        return conn;
    }
}
