
package DAO;

import Modelo.Envios;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ListarEnvios {
    
    public List<Envios> ListarTodosEnvios() throws Exception {
        List<Envios> objLista = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT DETA_VENTA.VENTA_ID,DETA_VENTA.ARTI_COD,ARTI_DATA.ARTI_NOM,DETA_VENTA.DETA_CANT,DETA_VENTA.PV_RUC,PROV_DATA.PV_RAZON,VENTAS.USER_DNI,USER_DATA.USER_NOMBRE,VENTAS.VENTA_U_LAT,VENTAS.VENTA_U_LONG,TO_CHAR(VENTAS.VENTA_FECHA,'DD/MM/YYYY'),DETA_VENTA.ESTA_ENVIO FROM DETA_VENTA INNER JOIN ARTI_DATA ON ARTI_DATA.ARTI_COD = DETA_VENTA.ARTI_COD INNER JOIN PROV_DATA ON PROV_DATA.PV_RUC = DETA_VENTA.PV_RUC INNER JOIN VENTAS ON VENTAS.VENTA_ID = DETA_VENTA.VENTA_ID INNER JOIN USER_DATA ON USER_DATA.USER_DNI = VENTAS.USER_DNI WHERE DETA_VENTA.ESTA_ENVIO=0 AND DETA_VENTA.ESTA_SELE=0 AND VENTAS.VENTA_ESTADO=1 ORDER BY VENTAS.VENTA_FECHA DESC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Envios objEnvios = new Envios();
                objEnvios.setCventa(rs.getString(1));
                objEnvios.setCarti(rs.getString(2));
                objEnvios.setArticulo(rs.getString(3));
                objEnvios.setCant(rs.getInt(4));
                objEnvios.setPv_ruc(rs.getLong(5));
                objEnvios.setRazon(rs.getString(6));
                objEnvios.setDni(rs.getInt(7));
                objEnvios.setNom(rs.getString(8));
                objEnvios.setLat(rs.getFloat(9));
                objEnvios.setLon(rs.getFloat(10));
                objEnvios.setFecha(rs.getString(11));
                objEnvios.setEstado(rs.getInt(12));
                objLista.add(objEnvios);
            }
        objConexion.CerraConexion();
        return objLista;
    }
     public Envios BuscarEnvio(Envios objenvios) throws Exception {
        Envios lista = new Envios();
        ConexionBD objConexion = new ConexionBD();
        try (PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT DETA_VENTA.VENTA_ID,DETA_VENTA.ARTI_COD,ARTI_DATA.ARTI_NOM,DETA_VENTA.DETA_CANT,DETA_VENTA.PV_RUC,PROV_DATA.PV_RAZON,VENTAS.USER_DNI,USER_DATA.USER_NOMBRE,VENTAS.VENTA_U_LAT,VENTAS.VENTA_U_LONG,TO_CHAR(VENTAS.VENTA_FECHA,'DD/MM/YYYY'),DETA_VENTA.ESTA_ENVIO FROM DETA_VENTA INNER JOIN ARTI_DATA ON ARTI_DATA.ARTI_COD = DETA_VENTA.ARTI_COD INNER JOIN PROV_DATA ON PROV_DATA.PV_RUC = DETA_VENTA.PV_RUC INNER JOIN VENTAS ON VENTAS.VENTA_ID = DETA_VENTA.VENTA_ID INNER JOIN USER_DATA ON USER_DATA.USER_DNI = VENTAS.USER_DNI WHERE DETA_VENTA.VENTA_ID=? AND DETA_VENTA.ARTI_COD=?")) {
            ps.setString(1, objenvios.getCventa());
            ps.setString(2, objenvios.getCarti());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.setCventa(rs.getString(1));
                lista.setCarti(rs.getString(2));
                lista.setArticulo(rs.getString(3));
                lista.setCant(rs.getInt(4));
                lista.setPv_ruc(rs.getLong(5));
                lista.setRazon(rs.getString(6));
                lista.setDni(rs.getInt(7));
                lista.setNom(rs.getString(8));
                lista.setLat(rs.getFloat(9));
                lista.setLon(rs.getFloat(10));
                lista.setFecha(rs.getString(11));
                lista.setEstado(rs.getInt(12));
            }
        }
        objConexion.CerraConexion();
        return lista;
    }
     
     public boolean Tomar_Entrega(String cod_venta, String cod_arti, Long pv_ruc_envio) throws Exception {
        ConexionBD objConexion = new ConexionBD();
        try (PreparedStatement ps = objConexion.getConexion().prepareStatement("UPDATE DETA_VENTA SET ESTA_SELE=1 , PV_RUC_ENVIO=? WHERE VENTA_ID = ? AND ARTI_COD=?")) {
            ps.setLong(1, pv_ruc_envio);
            ps.setString(2, cod_venta);
            ps.setString(3, cod_arti);
            ps.executeQuery();
        }
        objConexion.CerraConexion();
        return true;
    }
    
     public List<Envios> ListarEnviosRuc(String ruc) throws Exception {
        List<Envios> objLista = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        try (PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT DETA_VENTA.VENTA_ID,DETA_VENTA.ARTI_COD,ARTI_DATA.ARTI_NOM,DETA_VENTA.DETA_CANT,DETA_VENTA.PV_RUC,PROV_DATA.PV_RAZON,VENTAS.USER_DNI,USER_DATA.USER_NOMBRE,VENTAS.VENTA_U_LAT,VENTAS.VENTA_U_LONG,TO_CHAR(VENTAS.VENTA_FECHA,'DD/MM/YYYY'),DETA_VENTA.ESTA_ENVIO FROM DETA_VENTA INNER JOIN ARTI_DATA ON ARTI_DATA.ARTI_COD = DETA_VENTA.ARTI_COD INNER JOIN PROV_DATA ON PROV_DATA.PV_RUC = DETA_VENTA.PV_RUC INNER JOIN VENTAS ON VENTAS.VENTA_ID = DETA_VENTA.VENTA_ID INNER JOIN USER_DATA ON USER_DATA.USER_DNI = VENTAS.USER_DNI WHERE DETA_VENTA.ESTA_SELE=1 AND DETA_VENTA.PV_RUC_ENVIO=? ORDER BY VENTAS.VENTA_FECHA DESC")) {
            ps.setString(1, ruc);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Envios lista = new Envios();
                lista.setCventa(rs.getString(1));
                lista.setCarti(rs.getString(2));
                lista.setArticulo(rs.getString(3));
                lista.setCant(rs.getInt(4));
                lista.setPv_ruc(rs.getLong(5));
                lista.setRazon(rs.getString(6));
                lista.setDni(rs.getInt(7));
                lista.setNom(rs.getString(8));
                lista.setLat(rs.getFloat(9));
                lista.setLon(rs.getFloat(10));
                lista.setFecha(rs.getString(11));
                lista.setEstado(rs.getInt(12));
                objLista.add(lista);
            }
        }
        objConexion.CerraConexion();
        return objLista;
    }
    
     public boolean Completar_Envio(String cod_venta, String cod_arti) throws Exception {
        ConexionBD objConexion = new ConexionBD();
        try (PreparedStatement ps = objConexion.getConexion().prepareStatement("UPDATE DETA_VENTA SET ESTA_ENVIO=1 WHERE VENTA_ID = ? AND ARTI_COD=?")) {
            ps.setString(1, cod_venta);
            ps.setString(2, cod_arti);
            ps.executeQuery();
        }
        objConexion.CerraConexion();
        return true;
    }
}
