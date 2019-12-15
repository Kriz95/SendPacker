package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
 
public class ConexionBD {
    private Connection conn;
    private String url="jdbc:oracle:thin:@localhost:1521:XE";
    private String user="hr";
    private String pass="hr";
    public ConexionBD() {
         
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url,user,pass);
            conn.setAutoCommit(true);
        } catch (SQLException | ClassNotFoundException ex) {
            System.out.println("Error en la conexión de la base de datos");
        }
         
    }
    public Connection getConexion(){
        return conn;
    }
    public void CerraConexion() throws Exception{
        
        conn.close();
    }
    
}
