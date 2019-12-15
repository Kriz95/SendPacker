package DAO;

import Modelo.CarritoCompras;
import Modelo.Usuarios;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

public class CarritoyVentas {

    public CarritoCompras BuscarArticulo(String codarti, String cant) throws Exception {
        CarritoCompras objcarrito = new CarritoCompras();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement(" SELECT ARTI_DATA.ARTI_COD,ARTI_NOM,ARTI_PREC,ARTI_CANT,ARTI_DATA.ID_CAT,CATE_DATA.CAT_NOM,PV_RUC FROM ARTI_DATA INNER JOIN CATE_DATA ON ARTI_DATA.ID_CAT=CATE_DATA.ID_CAT WHERE ARTI_DATA.ARTI_COD=? AND ARTI_DATA.ARTI_ESTADO=1");
        ps.setString(1, codarti);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            objcarrito.setCod(rs.getString(1));
            objcarrito.setNom(rs.getString(2));
            objcarrito.setPrec(rs.getFloat(3));
            objcarrito.setCant(Integer.parseInt(cant));
            objcarrito.setTotal((Float) (Integer.parseInt(cant) * objcarrito.getPrec()));
            objcarrito.setPv_ruc(rs.getLong(7));
        }
        ps.close();
        objConexion.CerraConexion();
        return objcarrito;
    }

    public boolean Ingresar_Venta(List<CarritoCompras> list, Usuarios objUsuarios, String lati, String longi, String Total) throws Exception {
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("INSERT INTO VENTAS VALUES('V'||GEN_COD_VENTA.NEXTVAL,?,?,?,?,SYSDATE,1)");
        ps.setLong(1, objUsuarios.getDNI());
        ps.setFloat(2,Float.parseFloat(Total));
        ps.setFloat(3,Float.parseFloat(lati));
        ps.setFloat(4,Float.parseFloat(longi));
        ResultSet rs = ps.executeQuery();
        boolean flag=rs.next();
        ps = objConexion.getConexion().prepareStatement("INSERT INTO DETA_VENTA VALUES('V'||GEN_COD_VENTA.CURRVAL,?,?,?,?,0,0,NULL)");
        for(CarritoCompras lista : list){
        ps.setString(1, lista.getCod() );
        ps.setFloat(2, lista.getPrec());
        ps.setFloat(3,lista.getCant());
        ps.setLong(4,lista.getPv_ruc());
        rs = ps.executeQuery();}
        flag=rs.next();
        ps.close();
        objConexion.CerraConexion();
        return flag;
    }



}
