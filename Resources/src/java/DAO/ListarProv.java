package DAO;

import Modelo.Proveedor_E;
import Modelo.Proveedor_V;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ListarProv {

    public ArrayList<Proveedor_V> ListarProveedor_V(String RUC) throws Exception {
        ArrayList<Proveedor_V> objLista = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT PROV_DATA.PV_RUC,PV_RAZON,PV_DIREC,PV_CONTAC,PV_CONTAC_NUM,PV_UBI_LAT,PV_UBI_LON,PV_EMAIL,PV_ESTADO,TO_CHAR(PV_FEC_REGISTRO,'DD/MM/YYYY'),TO_CHAR(PV_FEC_UPDATE,'DD/MM/YYYY'),PROV_LOGIN.PV_PASS,PV_TYPE FROM PROV_DATA INNER JOIN PROV_LOGIN ON PROV_LOGIN.PV_RUC = PROV_DATA.PV_RUC WHERE PROV_LOGIN.PV_TYPE != 0 AND PROV_LOGIN.PV_TYPE != 2 AND PROV_DATA.PV_RUC LIKE ? ORDER BY PROV_DATA.PV_FEC_REGISTRO DESC");
        ps.setString(1, "%"+RUC+"%");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Proveedor_V objProveedor = new Proveedor_V();
            objProveedor.setRuc(rs.getLong(1));
            objProveedor.setRazon(rs.getString(2));
            objProveedor.setDireccion(rs.getString(3));
            objProveedor.setContacto(rs.getString(4));
            objProveedor.setNContacto(rs.getInt(5));
            objProveedor.setLati(rs.getString(6));
            objProveedor.setLong(rs.getString(7));
            objProveedor.setEmail(rs.getString(8));
            objProveedor.setEstado(rs.getInt(9));
            objProveedor.setF_reg(rs.getString(10));
            objProveedor.setF_mod(rs.getString(11));
            objProveedor.setPass(rs.getString(12));
            objProveedor.setTipo(rs.getInt(13));
            objLista.add(objProveedor);
        }
        ps.close();
        objConexion.CerraConexion();
        return objLista;
    }

    public ArrayList<Proveedor_E> ListarProveedor_E(String RUC) throws Exception {
        ArrayList<Proveedor_E> objLista = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT PROV_DATA.PV_RUC,PV_RAZON,PV_DIREC,PV_CONTAC,PV_CONTAC_NUM,PV_UBI_LAT,PV_UBI_LON,PV_EMAIL,PV_HINI,PV_HFIN,PV_ESTADO,TO_CHAR(PV_FEC_REGISTRO,'DD/MM/YYYY'),TO_CHAR(PV_FEC_UPDATE,'DD/MM/YYYY'),PROV_LOGIN.PV_PASS,PV_TYPE FROM PROV_DATA INNER JOIN PROV_LOGIN ON PROV_LOGIN.PV_RUC = PROV_DATA.PV_RUC WHERE PROV_LOGIN.PV_TYPE != 0 AND PROV_LOGIN.PV_TYPE != 1 AND PROV_DATA.PV_RUC LIKE ? ORDER BY PROV_DATA.PV_FEC_REGISTRO DESC");
        ps.setString(1, "%"+RUC+"%");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Proveedor_E objProveedor = new Proveedor_E();
            objProveedor.setRuc(rs.getLong(1));
            objProveedor.setRazon(rs.getString(2));
            objProveedor.setDireccion(rs.getString(3));
            objProveedor.setContacto(rs.getString(4));
            objProveedor.setNContacto(rs.getInt(5));
            objProveedor.setLati(rs.getString(6));
            objProveedor.setLong(rs.getString(7));
            objProveedor.setEmail(rs.getString(8));
            objProveedor.setHini(rs.getString(9));
            objProveedor.setHfin(rs.getString(10));
            objProveedor.setEstado(rs.getInt(11));
            objProveedor.setF_reg(rs.getString(12));
            objProveedor.setF_mod(rs.getString(13));
            objProveedor.setPass(rs.getString(14));
            objProveedor.setTipo(rs.getInt(15));
            objLista.add(objProveedor);
        }
        ps.close();
        objConexion.CerraConexion();
        return objLista;
    }

    public Proveedor_V BuscarProv_V(String ruc) throws Exception {
        Proveedor_V objProveedorV = new Proveedor_V();
        ConexionBD objConexionBD = new ConexionBD();
        PreparedStatement ps = objConexionBD.getConexion().prepareStatement("SELECT PROV_DATA.PV_RUC,PV_RAZON,PV_DIREC,PV_CONTAC,PV_CONTAC_NUM,PV_UBI_LAT,PV_UBI_LON,PV_EMAIL,PV_ESTADO,PROV_LOGIN.PV_PASS,PV_TYPE FROM PROV_DATA INNER JOIN PROV_LOGIN ON PROV_LOGIN.PV_RUC = PROV_DATA.PV_RUC WHERE PROV_LOGIN.PV_RUC = ?");
        ps.setString(1, ruc);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            objProveedorV.setRuc(rs.getLong(1));
            objProveedorV.setRazon(rs.getString(2));
            objProveedorV.setDireccion(rs.getString(3));
            objProveedorV.setContacto(rs.getString(4));
            objProveedorV.setNContacto(rs.getInt(5));
            objProveedorV.setLati(rs.getString(6));
            objProveedorV.setLong(rs.getString(7));
            objProveedorV.setEmail(rs.getString(8));
            objProveedorV.setEstado(rs.getInt(9));
            objProveedorV.setPass(rs.getString(10));
            objProveedorV.setTipo(rs.getInt(11));

        }

        ps.close();
        objConexionBD.CerraConexion();

        return objProveedorV;
    }

    public Proveedor_E BuscarProv_E(String ruc) throws Exception {
        Proveedor_E objProveedorE = new Proveedor_E();
        ConexionBD objConexionBD = new ConexionBD();
        PreparedStatement ps = objConexionBD.getConexion().prepareStatement("SELECT PROV_DATA.PV_RUC,PV_RAZON,PV_DIREC,PV_CONTAC,PV_CONTAC_NUM,PV_UBI_LAT,PV_UBI_LON,PV_EMAIL,PV_HINI,PV_HFIN,PV_ESTADO,PROV_LOGIN.PV_PASS,PV_TYPE FROM PROV_DATA INNER JOIN PROV_LOGIN ON PROV_LOGIN.PV_RUC = PROV_DATA.PV_RUC WHERE PROV_LOGIN.PV_RUC = ?");
        ps.setString(1, ruc);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            objProveedorE.setRuc(rs.getLong(1));
            objProveedorE.setRazon(rs.getString(2));
            objProveedorE.setDireccion(rs.getString(3));
            objProveedorE.setContacto(rs.getString(4));
            objProveedorE.setNContacto(rs.getInt(5));
            objProveedorE.setLati(rs.getString(6));
            objProveedorE.setLong(rs.getString(7));
            objProveedorE.setEmail(rs.getString(8));

            objProveedorE.setHini(rs.getString(9));
            objProveedorE.setHfin(rs.getString(10));
            objProveedorE.setEstado(rs.getInt(11));
            objProveedorE.setPass(rs.getString(12));
            objProveedorE.setTipo(rs.getInt(13));

        }
        ps.close();
        objConexionBD.CerraConexion();

        return objProveedorE;
    }

    public boolean EliminarProv(String ruc) throws Exception {
        ConexionBD objConexionBD = new ConexionBD();
        CallableStatement cls = objConexionBD.getConexion().prepareCall("{call DEL_PROV(?)}");
        cls.setString(1, ruc);
        cls.execute();
        return true;
    }

    public boolean ModificarP_V(Proveedor_V objProv) throws Exception {
        ConexionBD objConexionBD = new ConexionBD();
        CallableStatement cls = objConexionBD.getConexion().prepareCall("{call MOD_PROV(?,?,?,?,?,?,?,?,?,?,?)}");
        cls.setLong(1, objProv.getRuc());
        cls.setString(2, objProv.getRazon());
        cls.setString(3, objProv.getDireccion());
        cls.setString(4, objProv.getContacto());
        cls.setInt(5, objProv.getNContacto());
        cls.setString(6, objProv.getLati());
        cls.setString(7, objProv.getLong());
        cls.setString(8, objProv.getEmail());
        cls.setString(9, null);
        cls.setString(10, null);
        cls.setInt(11, objProv.getEstado());
        cls.execute();
        cls.close();
        objConexionBD.CerraConexion();
        return true;
    }

    public boolean ModificarP_E(Proveedor_E objProv) throws Exception {
        ConexionBD objConexionBD = new ConexionBD();
        CallableStatement cls = objConexionBD.getConexion().prepareCall("{call MOD_PROV(?,?,?,?,?,?,?,?,?,?,?)}");
        cls.setLong(1, objProv.getRuc());
        cls.setString(2, objProv.getRazon());
        cls.setString(3, objProv.getDireccion());
        cls.setString(4, objProv.getContacto());
        cls.setInt(5, objProv.getNContacto());
        cls.setString(6, objProv.getLati());
        cls.setString(7, objProv.getLong());
        cls.setString(8, objProv.getEmail());
        cls.setString(9, objProv.getHini());
        cls.setString(10, objProv.getHfin());
        cls.setInt(11, objProv.getEstado());
        cls.execute();
        cls.close();
        objConexionBD.CerraConexion();
        return true;
    }

    public boolean IngresarProv_E(Proveedor_E objProv) throws Exception {
        ConexionBD objConexionBD = new ConexionBD();
        CallableStatement cls = objConexionBD.getConexion().prepareCall("{call NEW_PROV(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
        cls.setLong(1, objProv.getRuc());
        cls.setString(2, objProv.getRazon());
        cls.setString(3, objProv.getDireccion());
        cls.setString(4, objProv.getContacto());
        cls.setInt(5, objProv.getNContacto());
        cls.setString(6, objProv.getLati());
        cls.setString(7, objProv.getLong());
        cls.setString(8, objProv.getEmail());
        cls.setString(9, objProv.getHini());
        cls.setString(10, objProv.getHfin());
        cls.setInt(11, objProv.getTipo());
        cls.setInt(12, 1);
        cls.setString(13, objProv.getPass());
        cls.execute();
        cls.close();
        objConexionBD.CerraConexion();
        return true;
    }

    public boolean IngresarProv_V(Proveedor_V objProv) throws Exception {
        ConexionBD objConexionBD = new ConexionBD();
        CallableStatement cls = objConexionBD.getConexion().prepareCall("{call NEW_PROV(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
        cls.setLong(1, objProv.getRuc());
        cls.setString(2, objProv.getRazon());
        cls.setString(3, objProv.getDireccion());
        cls.setString(4, objProv.getContacto());
        cls.setInt(5, objProv.getNContacto());
        cls.setString(6, objProv.getLati());
        cls.setString(7, objProv.getLong());
        cls.setString(8, objProv.getEmail());
        cls.setString(9, null);
        cls.setString(10, null);
        cls.setInt(11, objProv.getTipo());
        cls.setInt(12, 1);
        cls.setString(13, objProv.getPass());
        cls.execute();
        cls.close();
        objConexionBD.CerraConexion();
        return true;
    }

    public boolean CambiarPass(String oldpass, String newpass, String ruc) throws Exception {
        boolean flag = false;
        ConexionBD objConexionBD = new ConexionBD();
        PreparedStatement ps = objConexionBD.getConexion().prepareStatement("UPDATE PROV_LOGIN SET PV_PASS=? WHERE PV_RUC=? AND PV_PASS=?");
        ps.setString(1, newpass);
        ps.setString(2, ruc);
        ps.setString(3, oldpass);
        ResultSet rs = ps.executeQuery();
        flag = rs.next();
        ps.close();
        objConexionBD.CerraConexion();
        return flag;
    }
}
