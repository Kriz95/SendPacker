package DAO;

import Modelo.IngresosPV;
import Modelo.TotalAños;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DatoEstadistica {

    public ArrayList<String> ListarAños(String ruc) throws Exception {
        ConexionBD objConexion = new ConexionBD();
        ArrayList<String> listaaño = new ArrayList();
        PreparedStatement ps;
        ps = objConexion.getConexion().prepareStatement("SELECT DISTINCT EXTRACT(YEAR FROM VENTAS.VENTA_FECHA) FROM VENTAS INNER JOIN DETA_VENTA ON VENTAS.VENTA_ID = DETA_VENTA.VENTA_ID WHERE DETA_VENTA.PV_RUC=? ORDER BY EXTRACT(YEAR FROM VENTAS.VENTA_FECHA)");
        ps.setString(1, ruc);
        ResultSet rs = ps.executeQuery();
        //SELECT sum(monto),year(fecha) FROM `ingresos` ORDER BY year(fecha)
        //SELECT sum(monto),year(fecha) FROM `ingresos`WHERE year(fecha)='(Select DISTINCT year(fecha) from ingresos)'
        while (rs.next()) {
            listaaño.add(rs.getString(1));
        }
        ps.close();
        objConexion.CerraConexion();
        return listaaño;
    }

    public ArrayList<IngresosPV> ListaIngresosMeses(String ruc, int año) throws Exception {
        ArrayList<IngresosPV> objIngresos = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps;
        ps = objConexion.getConexion().prepareStatement("SELECT VENTAS.VENTA_ID,DETA_VENTA.PV_RUC, SUM(DETA_VENTA.DETA_PREC*DETA_VENTA.DETA_CANT), EXTRACT(MONTH FROM VENTAS.VENTA_FECHA) FROM VENTAS INNER JOIN DETA_VENTA ON VENTAS.VENTA_ID = DETA_VENTA.VENTA_ID WHERE EXTRACT(YEAR FROM VENTAS.VENTA_FECHA)=? AND DETA_VENTA.PV_RUC = ? GROUP BY EXTRACT(MONTH FROM VENTAS.VENTA_FECHA), VENTAS.VENTA_FECHA, VENTAS.VENTA_ID, DETA_VENTA.PV_RUC");
        ps.setInt(1, año);
        ps.setString(2, ruc);
        ResultSet rs = ps.executeQuery();
        //SELECT sum(monto),year(fecha) FROM `ingresos` ORDER BY year(fecha)
        //SELECT sum(monto),year(fecha) FROM `ingresos`WHERE year(fecha)='(Select DISTINCT year(fecha) from ingresos)'
        while (rs.next()) {
            IngresosPV ingresos = new IngresosPV();
            ingresos.setId(rs.getString(1));
            ingresos.setEncargado(rs.getString(2));
            ingresos.setMonto(rs.getFloat(3));
            ingresos.setFecha(rs.getString(4));
            objIngresos.add(ingresos);
        }
        ps.close();
        objConexion.CerraConexion();
        return objIngresos;
    }
    
    public ArrayList<TotalAños> ListaIngresosAños(String ruc) throws Exception {
        ArrayList<TotalAños> objIngresosA = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps;
        ps = objConexion.getConexion().prepareStatement("SELECT DETA_VENTA.PV_RUC,SUM(DETA_VENTA.DETA_PREC),EXTRACT(YEAR FROM VENTA_FECHA) FROM VENTAS INNER JOIN DETA_VENTA ON DETA_VENTA.VENTA_ID = VENTAS.VENTA_ID WHERE DETA_VENTA.PV_RUC = ? GROUP BY EXTRACT(YEAR FROM VENTA_FECHA), DETA_VENTA.PV_RUC ORDER BY EXTRACT(YEAR FROM VENTA_FECHA) ASC");
        ps.setString(1, ruc);
        ResultSet rs = ps.executeQuery();
        //SELECT sum(monto),year(fecha) FROM `ingresos` ORDER BY year(fecha)
        //SELECT sum(monto),year(fecha) FROM `ingresos`WHERE year(fecha)='(Select DISTINCT year(fecha) from ingresos)'
        while (rs.next()) {
            TotalAños ingresos = new TotalAños();
            ingresos.setTotal(rs.getFloat(2));
            ingresos.setYear(rs.getString(3));
            objIngresosA.add(ingresos);
        }
        ps.close();
        objConexion.CerraConexion();
        return objIngresosA;
    }
    public List<String> RankingMesPasado (String ruc) throws Exception{
        List<String> objRank = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT DETA_VENTA.ARTI_COD, ARTI_DATA.ARTI_NOM , SUM(DETA_VENTA.DETA_CANT)AS CONT FROM DETA_VENTA INNER JOIN ARTI_DATA ON ARTI_DATA.ARTI_COD = DETA_VENTA.ARTI_COD INNER JOIN VENTAS ON DETA_VENTA.VENTA_ID = VENTAS.VENTA_ID  WHERE DETA_VENTA.PV_RUC = ? AND EXTRACT(MONTH FROM VENTAS.VENTA_FECHA) = EXTRACT(month FROM SYSDATE)-1 GROUP BY DETA_VENTA.ARTI_COD, ARTI_DATA.ARTI_NOM ORDER BY CONT DESC");
        ps.setString(1, ruc);
        ResultSet rs = ps.executeQuery();
        while (rs.next()){
            objRank.add(rs.getString(1));
            objRank.add(rs.getString(2));
            objRank.add(rs.getString(3));
        }
        ps.close();
        objConexion.CerraConexion();
        return objRank;
    }
    
     public List<String> ListaTop5Articulos(Long ruc) throws Exception {
        List<String> objListRank5 = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        //Consulta de rango de fecha actual y 5 meses antes
        int [] date = RangeDate(5);
        PreparedStatement ps;
        ps = objConexion.getConexion().prepareStatement("SELECT * FROM (SELECT DETA_VENTA.ARTI_COD,SUM(DETA_VENTA.DETA_CANT*DETA_VENTA.DETA_PREC) AS RANKING FROM VENTAS INNER JOIN DETA_VENTA ON VENTAS.VENTA_ID = DETA_VENTA.VENTA_ID WHERE DETA_VENTA.PV_RUC = ? AND VENTAS.VENTA_FECHA BETWEEN TO_DATE(?,'DD/MM/YYYY') AND SYSDATE GROUP BY DETA_VENTA.ARTI_COD ORDER BY RANKING DESC) WHERE ROWNUM<6");
        ps.setLong(1, ruc);
        ps.setString(2,"01/"+date[0]+"/"+date[1]);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            objListRank5.add(rs.getString(1));
        }
        ps.close();
        objConexion.CerraConexion();
        return objListRank5;
    }
     
     public int[] RangeDate(int res) throws Exception {
        int[] date = new int [2];
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps;
        // Extraer Fecha actual
        ps = objConexion.getConexion().prepareStatement("SELECT EXTRACT(MONTH FROM SYSDATE), EXTRACT(YEAR FROM SYSDATE) FROM DUAL");
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            date[0] = rs.getInt(1);
            date[1] = rs.getInt(2);
        }
        //Identificar 5 meses atras
        int aux1 = date[0]-res;
        if(aux1<1){
            date[0] = 12+aux1;
            date[1] = date[1]-1;
        }else{
            date[0] = aux1;
        }
        ps.close();
        objConexion.CerraConexion();
        return date;      
     }
     
     public double[][] TotalporArticulo(Long ruc, String cod_arti) throws Exception {
        double[][] data = new double [6][3];
        ConexionBD objConexion = new ConexionBD();
        //Extraer Fecha de 5 meses antes
        int[] date = RangeDate(5);
        PreparedStatement ps;
        ps = objConexion.getConexion().prepareStatement("SELECT EXTRACT(MONTH FROM VENTAS.VENTA_FECHA),EXTRACT (YEAR FROM VENTAS.VENTA_FECHA), DETA_VENTA.ARTI_COD, SUM((DETA_VENTA.DETA_PREC*DETA_VENTA.DETA_CANT)) AS TOTAL FROM VENTAS INNER JOIN DETA_VENTA ON VENTAS.VENTA_ID = DETA_VENTA.VENTA_ID WHERE DETA_VENTA.PV_RUC = ? AND DETA_VENTA.ARTI_COD = ? AND VENTAS.VENTA_ESTADO=1 AND VENTAS.VENTA_FECHA BETWEEN TO_DATE(?,'DD/MM/YYYY') AND SYSDATE GROUP BY EXTRACT(MONTH FROM VENTAS.VENTA_FECHA), EXTRACT (YEAR FROM VENTAS.VENTA_FECHA), DETA_VENTA.ARTI_COD ORDER BY EXTRACT (YEAR FROM VENTAS.VENTA_FECHA) ASC, EXTRACT(MONTH FROM VENTAS.VENTA_FECHA)");
        ps.setLong(1, ruc);
        ps.setString(2, cod_arti);
        ps.setString(3,"01/"+date[0]+"/"+date[1]);
        ResultSet rs = ps.executeQuery();
        int i = 0;
        while (rs.next()) {
            data[i][0] = rs.getInt(1);
            data[i][1] = rs.getInt(2);
            data[i][2] = rs.getDouble(4);
            i++;
            
        }
        ps.close();
        objConexion.CerraConexion();
        return data;
    }
    
    

}
