package DAO;

import Modelo.Usuarios;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ListarUsuarios {

    public ArrayList<Usuarios> ListarUsuarios(String DNI) throws Exception {
        ArrayList<Usuarios> objLista = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT USER_DATA.USER_DNI,USER_NOMBRE,USER_APELL_PAT,USER_APELL_MAT,USER_EMAIL,USER_CEL,USER_ESTADO,TO_CHAR(USER_FECHA_REGISTRO,'DD/MM/YYYY'),TO_CHAR(USER_FEC_UPDATE,'DD/MM/YYYY'),USER_LOGIN.USER_PASS FROM USER_DATA INNER JOIN USER_LOGIN ON USER_LOGIN.USER_DNI = USER_DATA.USER_DNI WHERE USER_DATA.USER_DNI LIKE ? ORDER BY USER_DATA.USER_FECHA_REGISTRO DESC");
        ps.setString(1,"%"+DNI+"%");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Usuarios objUsuarios = new Usuarios();
            objUsuarios.setDNI(rs.getLong(1));
            objUsuarios.setNombres(rs.getString(2));
            objUsuarios.setApelPaterno(rs.getString(3));
            objUsuarios.setApelMaterno(rs.getString(4));
            objUsuarios.setEmail(rs.getString(5));
            objUsuarios.setCel(rs.getInt(6));
            objUsuarios.setEstado(rs.getInt(7));
            objUsuarios.setF_reg(rs.getString(8));
            objUsuarios.setF_mod(rs.getString(9));
            objUsuarios.setPass(rs.getString(10));
            objLista.add(objUsuarios);
        }
        ps.close();
        objConexion.CerraConexion();
        return objLista;
    }

    public Usuarios BuscarUsu(String dni) throws SQLException, Exception {
        Usuarios objUsuarios = new Usuarios();
        ConexionBD objConexionBD = new ConexionBD();
        PreparedStatement ps = objConexionBD.getConexion().prepareStatement("SELECT USER_DATA.USER_DNI,USER_NOMBRE,USER_APELL_PAT,USER_APELL_MAT,USER_EMAIL,USER_CEL,USER_ESTADO,USER_FECHA_REGISTRO,USER_FEC_UPDATE,USER_LOGIN.USER_PASS FROM USER_DATA INNER JOIN USER_LOGIN ON USER_LOGIN.USER_DNI = USER_DATA.USER_DNI WHERE USER_DATA.USER_DNI = ?");
        ps.setString(1, dni);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            objUsuarios.setDNI(rs.getLong(1));
            objUsuarios.setNombres(rs.getString(2));
            objUsuarios.setApelPaterno(rs.getString(3));
            objUsuarios.setApelMaterno(rs.getString(4));
            objUsuarios.setEmail(rs.getString(5));
            objUsuarios.setCel(rs.getInt(6));
            objUsuarios.setEstado(rs.getInt(7));
            objUsuarios.setF_reg(rs.getString(8));
            objUsuarios.setF_mod(rs.getString(9));
            objUsuarios.setPass(rs.getString(10));
        }

        ps.close();
        objConexionBD.CerraConexion();

        return objUsuarios;
    }

    public boolean ModificarU(Usuarios objusu) throws Exception {
        ConexionBD objConexionBD = new ConexionBD();
        CallableStatement cls = objConexionBD.getConexion().prepareCall("{call MOD_USER(?,?,?,?,?,?,?)}");
        cls.setLong(1, objusu.getDNI());
        cls.setString(2, objusu.getNombres());
        cls.setString(3, objusu.getApelPaterno());
        cls.setString(4, objusu.getApelMaterno());
        cls.setString(5, objusu.getEmail());
        cls.setInt(6, objusu.getCel());
        cls.setInt(7, objusu.getEstado());
        cls.execute();
        cls.close();
        objConexionBD.CerraConexion();
        return true;
    }

    public boolean CambiarPass(String oldpass, String newpass, String dni) throws Exception {
        boolean flag=false;
        ConexionBD objConexionBD = new ConexionBD();
        PreparedStatement ps = objConexionBD.getConexion().prepareStatement("UPDATE USER_LOGIN SET USER_PASS=? WHERE USER_DNI=? AND USER_PASS=?");
        ps.setString(1, newpass);
        ps.setString(2, dni);
        ps.setString(3, oldpass);
        ResultSet rs = ps.executeQuery();
        flag = rs.next();
        ps.close();
        objConexionBD.CerraConexion();
        return flag;
    }

    public boolean EliminarU(String dni) throws Exception {
        ConexionBD objConexionBD = new ConexionBD();
        CallableStatement cls = objConexionBD.getConexion().prepareCall("{call DEL_USER(?)}");
        cls.setString(1, dni);
        cls.execute();
        return true;
    }

    public boolean RegistrarU(Usuarios objUsuarios) throws Exception {
        ConexionBD objConexionBD = new ConexionBD();
        boolean flag;
        CallableStatement cls = objConexionBD.getConexion().prepareCall("{call NEW_USER(?,?,?,?,?,?,?)}");
        cls.setLong(1, objUsuarios.getDNI());
        cls.setString(3, objUsuarios.getApelPaterno());
        cls.setString(2, objUsuarios.getNombres());
        cls.setString(4, objUsuarios.getApelMaterno());
        cls.setString(5, objUsuarios.getEmail());
        cls.setInt(6, objUsuarios.getCel());
        cls.setString(7, objUsuarios.getPass());
        flag = cls.execute();
        return flag;
    }

}
