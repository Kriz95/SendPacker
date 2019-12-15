package DAO;

import Modelo.CarritoCompras;
import Modelo.Ventas;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ListarVentas {

    public List<Ventas> ListarVentas(String cod_v) throws Exception {
        List<Ventas> objListVentas = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT VENTAS.VENTA_ID, TO_CHAR(VENTAS.VENTA_FECHA,'DD/MM/YYYY'), VENTAS.USER_DNI, USER_DATA.USER_NOMBRE,VENTAS.VENTA_U_LAT, VENTAS.VENTA_U_LONG, VENTAS.VENTA_T, VENTAS.VENTA_ESTADO  FROM VENTAS INNER JOIN USER_DATA ON VENTAS.USER_DNI = USER_DATA.USER_DNI WHERE VENTAS.VENTA_ID LIKE ? ORDER BY VENTAS.VENTA_FECHA DESC");
        ps.setString(1, "%" + cod_v + "%");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Ventas objVentas = new Ventas();
            objVentas.setCodv(rs.getString(1));
            objVentas.setFechav(rs.getString(2));
            objVentas.setDNI(rs.getInt(3));
            objVentas.setNDNI(rs.getString(4));
            objVentas.setLatV(rs.getFloat(5));
            objVentas.setLongV(rs.getFloat(6));
            objVentas.setTotalV(rs.getFloat(7));
            objVentas.setEstadoV(rs.getInt(8));
            objListVentas.add(objVentas);
        }
        ps.close();
        objConexion.CerraConexion();
        return objListVentas;
    }

    public boolean DeshabilitarVenta(String codv) throws Exception {
        boolean flag = false;
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("UPDATE VENTAS VALUE SET VENTA_ESTADO = 0 WHERE VENTA_ID = ? ");
        ps.setString(1, codv);
        flag = ps.execute();
        ps.close();
        objConexion.CerraConexion();
        return flag;
    }

    public Ventas BuscarVenta(String codv) throws Exception {
        Ventas objVentas = new Ventas();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT VENTAS.VENTA_ID, TO_CHAR(VENTAS.VENTA_FECHA,'YYYY-MM-DD'), VENTAS.USER_DNI, USER_DATA.USER_NOMBRE,VENTAS.VENTA_U_LAT, VENTAS.VENTA_U_LONG, VENTAS.VENTA_T, VENTAS.VENTA_ESTADO  FROM VENTAS INNER JOIN USER_DATA ON VENTAS.USER_DNI = USER_DATA.USER_DNI WHERE VENTAS.VENTA_ID=?");
        ps.setString(1, codv);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            objVentas.setCodv(rs.getString(1));
            objVentas.setFechav(rs.getString(2));
            objVentas.setDNI(rs.getInt(3));
            objVentas.setNDNI(rs.getString(4));
            objVentas.setLatV(rs.getFloat(5));
            objVentas.setLongV(rs.getFloat(6));
            objVentas.setTotalV(rs.getFloat(7));
            objVentas.setEstadoV(rs.getInt(8));
        }
        ps.close();
        objConexion.CerraConexion();
        return objVentas;
    }

    public boolean ActualizarVentas(String codv, String dni, String total, String lat, String longi, String estado, String Fecha) throws Exception {
        boolean flag = false;
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("UPDATE VENTAS SET USER_DNI=?, VENTA_T=?, VENTA_U_LAT=?, VENTA_U_LONG=?, VENTA_FECHA=TO_DATE(?,'YYYY-MM-DD'), VENTA_ESTADO=? WHERE VENTA_ID=?");
        ps.setInt(1, Integer.parseInt(dni));
        ps.setFloat(2, Float.parseFloat(total));
        ps.setFloat(3, Float.parseFloat(lat));
        ps.setFloat(4, Float.parseFloat(longi));
        ps.setString(5, Fecha);
        ps.setInt(6, Integer.parseInt(estado));
        ps.setString(7, codv);
        flag = ps.execute();
        ps.close();
        objConexion.CerraConexion();
        return flag;
    }

    public List<CarritoCompras> BuscarDetalle(String codv) throws Exception {
        List<CarritoCompras> objListaCarrito = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT DETA_VENTA.VENTA_ID,DETA_VENTA.ARTI_COD, ARTI_DATA.ARTI_NOM, DETA_VENTA.DETA_PREC, DETA_VENTA.DETA_CANT FROM DETA_VENTA INNER JOIN ARTI_DATA ON DETA_VENTA.ARTI_COD = ARTI_DATA.ARTI_COD WHERE DETA_VENTA.VENTA_ID=?");
        ps.setString(1, codv);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            CarritoCompras objCarrito = new CarritoCompras();
            objCarrito.setCod(rs.getString(2));
            objCarrito.setNom(rs.getString(3));
            objCarrito.setPrec(rs.getFloat(4));
            objCarrito.setCant(rs.getInt(5));
            objListaCarrito.add(objCarrito);
        }
        ps.close();
        objConexion.CerraConexion();
        return objListaCarrito;
    }

    public List<CarritoCompras> BuscarDetaVentasProv(Long ruc, String mes, String año) throws Exception {
        List<CarritoCompras> objListaCarrito = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = null;
        if (mes == null || año == null) {
            ps = objConexion.getConexion().prepareStatement("SELECT DETA_VENTA.VENTA_ID,DETA_VENTA.ARTI_COD, ARTI_DATA.ARTI_NOM, DETA_VENTA.DETA_PREC, DETA_VENTA.DETA_CANT, TO_CHAR(VENTAS.VENTA_FECHA,'DD/MM/YYYY'),VENTAS.VENTA_ESTADO FROM DETA_VENTA INNER JOIN ARTI_DATA ON DETA_VENTA.ARTI_COD = ARTI_DATA.ARTI_COD INNER JOIN VENTAS ON VENTAS.VENTA_ID = DETA_VENTA.VENTA_ID WHERE DETA_VENTA.PV_RUC=? AND EXTRACT(MONTH FROM VENTAS.VENTA_FECHA)=EXTRACT(MONTH FROM SYSDATE) AND EXTRACT(YEAR FROM VENTAS.VENTA_FECHA)=EXTRACT(YEAR FROM SYSDATE) ORDER BY VENTAS.VENTA_FECHA DESC");
        } else {
            ps = objConexion.getConexion().prepareStatement("SELECT DETA_VENTA.VENTA_ID,DETA_VENTA.ARTI_COD, ARTI_DATA.ARTI_NOM, DETA_VENTA.DETA_PREC, DETA_VENTA.DETA_CANT, TO_CHAR(VENTAS.VENTA_FECHA,'DD/MM/YYYY'), VENTAS.VENTA_ESTADO FROM DETA_VENTA INNER JOIN ARTI_DATA ON DETA_VENTA.ARTI_COD = ARTI_DATA.ARTI_COD INNER JOIN VENTAS ON VENTAS.VENTA_ID = DETA_VENTA.VENTA_ID WHERE DETA_VENTA.PV_RUC=? AND EXTRACT(MONTH FROM VENTAS.VENTA_FECHA)=? AND EXTRACT(YEAR FROM VENTAS.VENTA_FECHA)=? ORDER BY VENTAS.VENTA_FECHA DESC");
            ps.setString(2, mes);
            ps.setString(3, año);
        }
        ps.setLong(1, ruc);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            CarritoCompras objCarrito = new CarritoCompras();
            objCarrito.setDescrip(rs.getString(1));//Lo uso para conseguir el ID VENTA(Por afinidad de datos)
            objCarrito.setCod(rs.getString(2));
            objCarrito.setNom(rs.getString(3));
            objCarrito.setPrec(rs.getFloat(4));

            objCarrito.setCant(rs.getInt(5));
            objCarrito.setF_reg(rs.getString(6));
            objCarrito.setArti_estado(rs.getInt(7));
            objListaCarrito.add(objCarrito);
        }
        ps.close();
        objConexion.CerraConexion();
        return objListaCarrito;
    }

    public List<CarritoCompras> FiltrarComprasUser(String DNI, String mes, String año) throws Exception {
        List<CarritoCompras> objListaCarrito = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = null;
        if (mes == null || año == null) {
            ps = objConexion.getConexion().prepareStatement("SELECT DETA_VENTA.VENTA_ID,DETA_VENTA.ARTI_COD, ARTI_DATA.ARTI_NOM, DETA_VENTA.DETA_PREC, DETA_VENTA.DETA_CANT, TO_CHAR(VENTAS.VENTA_FECHA,'DD-MM-YYYY') FROM DETA_VENTA INNER JOIN ARTI_DATA ON DETA_VENTA.ARTI_COD = ARTI_DATA.ARTI_COD INNER JOIN VENTAS ON VENTAS.VENTA_ID = DETA_VENTA.VENTA_ID WHERE VENTAS.USER_DNI=? AND EXTRACT(MONTH FROM VENTAS.VENTA_FECHA)=EXTRACT(MONTH FROM SYSDATE) AND EXTRACT(YEAR FROM VENTAS.VENTA_FECHA)=EXTRACT(YEAR FROM SYSDATE) ORDER BY VENTAS.VENTA_FECHA");
        } else {
            ps = objConexion.getConexion().prepareStatement("SELECT DETA_VENTA.VENTA_ID,DETA_VENTA.ARTI_COD, ARTI_DATA.ARTI_NOM, DETA_VENTA.DETA_PREC, DETA_VENTA.DETA_CANT, TO_CHAR(VENTAS.VENTA_FECHA,'DD-MM-YYYY') FROM DETA_VENTA INNER JOIN ARTI_DATA ON DETA_VENTA.ARTI_COD = ARTI_DATA.ARTI_COD INNER JOIN VENTAS ON VENTAS.VENTA_ID = DETA_VENTA.VENTA_ID WHERE VENTAS.USER_DNI=? AND EXTRACT(MONTH FROM VENTAS.VENTA_FECHA)=? AND EXTRACT(YEAR FROM VENTAS.VENTA_FECHA)=? ORDER BY VENTAS.VENTA_FECHA");
            ps.setString(2, mes);
            ps.setString(3, año);
        }
        ps.setString(1, DNI);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            CarritoCompras objCarrito = new CarritoCompras();
            objCarrito.setCat(rs.getString(1));
            objCarrito.setCod(rs.getString(2));
            objCarrito.setNom(rs.getString(3));
            objCarrito.setPrec(rs.getFloat(4));
            objCarrito.setCant(rs.getInt(5));
            objCarrito.setF_reg(rs.getString(6));
            objListaCarrito.add(objCarrito);
        }
        ps.close();
        objConexion.CerraConexion();
        return objListaCarrito;
    }

    public List<String> ListarMesesyAños(String DNI) throws Exception {
        List<String> objList = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT EXTRACT(MONTH FROM VENTAS.VENTA_FECHA), EXTRACT(YEAR FROM VENTAS.VENTA_FECHA) FROM DETA_VENTA INNER JOIN VENTAS ON VENTAS.VENTA_ID = DETA_VENTA.VENTA_ID  WHERE VENTAS.USER_DNI=? GROUP BY EXTRACT(MONTH FROM VENTAS.VENTA_FECHA), EXTRACT(YEAR FROM VENTAS.VENTA_FECHA) ORDER BY EXTRACT(MONTH FROM VENTAS.VENTA_FECHA) , EXTRACT(YEAR FROM VENTAS.VENTA_FECHA) DESC");
        ps.setString(1, DNI);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            objList.add(rs.getNString(1) + "/" + rs.getString(2));
        }
        ps.close();
        objConexion.CerraConexion();
        return objList;
    }

    public List<String> ListarMesesyAñosProv(Long RUC) throws Exception {
        List<String> objList = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT EXTRACT(MONTH FROM VENTAS.VENTA_FECHA), EXTRACT(YEAR FROM VENTAS.VENTA_FECHA) FROM DETA_VENTA INNER JOIN VENTAS ON VENTAS.VENTA_ID = DETA_VENTA.VENTA_ID WHERE DETA_VENTA.PV_RUC=?  GROUP BY EXTRACT(MONTH FROM VENTAS.VENTA_FECHA), EXTRACT(YEAR FROM VENTAS.VENTA_FECHA) ORDER BY EXTRACT(MONTH FROM VENTAS.VENTA_FECHA), EXTRACT(YEAR FROM VENTAS.VENTA_FECHA) ASC");
        ps.setLong(1, RUC);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            objList.add(rs.getNString(1) + "/" + rs.getString(2));
        }
        ps.close();
        objConexion.CerraConexion();
        return objList;
    }

    public List<String> ReporteVentas(Long ruc, String mes, String año) throws Exception {
        List<String> objLista = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT DETA_VENTA.ARTI_COD, ARTI_DATA.ARTI_NOM, SUM(DETA_VENTA.DETA_CANT) FROM DETA_VENTA INNER JOIN ARTI_DATA ON DETA_VENTA.ARTI_COD = ARTI_DATA.ARTI_COD INNER JOIN VENTAS ON VENTAS.VENTA_ID = DETA_VENTA.VENTA_ID WHERE DETA_VENTA.PV_RUC=? AND EXTRACT(MONTH FROM VENTAS.VENTA_FECHA)=? AND EXTRACT(YEAR FROM VENTAS.VENTA_FECHA)=? AND VENTAS.VENTA_ESTADO = 1 GROUP BY DETA_VENTA.ARTI_COD,ARTI_DATA.ARTI_NOM");
        ps.setLong(1, ruc);
        ps.setString(2, mes);
        ps.setString(3, año);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            objLista.add(rs.getString(2));
            objLista.add(rs.getString(3));
        }
        ps.close();
        objConexion.CerraConexion();
        return objLista;
    }

}
