package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ValLoginImp {

    public boolean ValLoginProv(String ruc, String pass) throws Exception {
        ConexionBD con = new ConexionBD();
        PreparedStatement ps = con.getConexion().prepareStatement("SELECT PROV_LOGIN.PV_RUC,PV_PASS,PROV_DATA.PV_ESTADO FROM PROV_LOGIN INNER JOIN PROV_DATA ON PROV_LOGIN.PV_RUC = PROV_DATA.PV_RUC WHERE PROV_LOGIN.PV_RUC= ? AND PROV_LOGIN.PV_PASS= ? AND PROV_DATA.PV_ESTADO=1");
        ps.setString(1, ruc);
        ps.setString(2, pass);
        ResultSet rs = ps.executeQuery();
        boolean val = rs.next();
        ps.close();
        con.CerraConexion();
        return val;
    }

    public int ValLoginProv(String ruc) throws Exception {
        ConexionBD con = new ConexionBD();
        PreparedStatement ps = con.getConexion().prepareStatement("SELECT PV_TYPE FROM PROV_LOGIN WHERE PV_RUC= ?");
        ps.setString(1, ruc);
        ResultSet rs = ps.executeQuery();
        int Tipo = 0;
        while (rs.next()) {
            Tipo = rs.getInt(1);
        }
        ps.close();
        con.CerraConexion();
        return Tipo;
    }

    public boolean ValLoginUser(String dni, String pass) throws Exception {
        boolean flag;
        ConexionBD con = new ConexionBD();
        String consultaclientesBD = "SELECT * FROM USER_LOGIN WHERE USER_DNI = ? AND USER_PASS = ?";
        PreparedStatement ps = con.getConexion().prepareStatement(consultaclientesBD);
        ps.setString(1, dni);
        ps.setString(2, pass);
        ResultSet rs = ps.executeQuery();
        flag = rs.next();
        return flag;

    }
}
