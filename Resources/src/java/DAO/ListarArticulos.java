package DAO;

import Modelo.Articulos;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ListarArticulos {

    public ArrayList<Articulos> BuscarArticulos(Long ruc, String cod_arti) throws Exception {
        ArrayList<Articulos> objLista = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT ARTI_DATA.ARTI_COD,ARTI_NOM,ARTI_DESCRIP,ARTI_PREC,ARTI_CANT,ARTI_DATA.ID_CAT,CATE_DATA.CAT_NOM,PV_RUC,TO_CHAR(ARTI_FECHA,'DD/MM/YYYY'),TO_CHAR(ARTI_FECHA_MOD,'DD/MM/YYYY'),ARTI_DATA.ARTI_ESTADO FROM ARTI_DATA INNER JOIN CATE_DATA ON ARTI_DATA.ID_CAT=CATE_DATA.ID_CAT  WHERE ARTI_DATA.PV_RUC=? AND ARTI_DATA.ARTI_COD LIKE ? ORDER BY ARTI_DATA.ARTI_FECHA DESC");
        ps.setLong(1, ruc);
        ps.setString(2,"%"+cod_arti+"%");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Articulos lista = new Articulos();
            lista.setCod(rs.getString(1));
            lista.setNom(rs.getString(2));
            lista.setDescrip(rs.getString(3));
            lista.setPrecio(rs.getFloat(4));
            lista.setCant(rs.getInt(5));
            lista.setCat(rs.getString(6));
            lista.setNcat(rs.getString(7));
            lista.setPv_ruc(rs.getLong(8));
            lista.setF_reg(rs.getString(9));
            lista.setF_mod(rs.getString(10));
            lista.setArti_estado(rs.getInt(11));
            objLista.add(lista);
        }
        ps.close();
        objConexion.CerraConexion();
        return objLista;
    }

    public Articulos BuscarArticulo(String cod) throws Exception {
        Articulos objLista = new Articulos();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement(" SELECT ARTI_DATA.ARTI_COD,ARTI_NOM,ARTI_PREC,ARTI_CANT,ARTI_DATA.ID_CAT,CATE_DATA.CAT_NOM, ARTI_DATA.ARTI_DESCRIP, ARTI_DATA.ARTI_ESTADO, IMG_DATA.RUTA_IMG FROM ARTI_DATA INNER JOIN CATE_DATA ON ARTI_DATA.ID_CAT=CATE_DATA.ID_CAT INNER JOIN IMG_DATA ON IMG_DATA.ARTI_COD = ARTI_DATA.ARTI_COD WHERE ARTI_DATA.ARTI_COD=?");
        ps.setString(1, cod);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            objLista.setCod(rs.getString(1));
            objLista.setNom(rs.getString(2));
            objLista.setPrecio(rs.getFloat(3));
            objLista.setCant(rs.getInt(4));
            objLista.setCat(rs.getString(5));
            objLista.setNcat(rs.getString(6));
            objLista.setDescrip(rs.getString(7));
            objLista.setArti_estado(rs.getInt(8));
            objLista.setRutaimg(rs.getString(9));

        }
        ps.close();
        objConexion.CerraConexion();
        return objLista;
    }

    public List<Articulos> ListarArticulos() throws Exception {
        List<Articulos> objlista = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT DISTINCT ARTI_DATA.ARTI_COD,ARTI_NOM,ARTI_DESCRIP,ARTI_PREC,ARTI_CANT,ARTI_DATA.ID_CAT,CATE_DATA.CAT_NOM,PV_RUC,ARTI_FECHA,ARTI_FECHA_MOD,IMG_DATA.RUTA_IMG FROM ARTI_DATA INNER JOIN CATE_DATA ON ARTI_DATA.ID_CAT=CATE_DATA.ID_CAT INNER JOIN IMG_DATA ON IMG_DATA.ARTI_COD=ARTI_DATA.ARTI_COD WHERE ARTI_DATA.ARTI_ESTADO=1");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Articulos lista = new Articulos();
            lista.setCod(rs.getString(1));
            lista.setNom(rs.getString(2));
            lista.setDescrip(rs.getString(3));
            lista.setPrecio(rs.getFloat(4));
            lista.setCant(rs.getInt(5));
            lista.setCat(rs.getString(6));
            lista.setNcat(rs.getString(7));
            lista.setPv_ruc(rs.getLong(8));
            lista.setF_reg(rs.getString(9));
            lista.setF_mod(rs.getString(10));
            lista.setRutaimg(rs.getString(11));
            objlista.add(lista);
        }
        ps.close();
        objConexion.CerraConexion();
        return objlista;
    }

    public ArrayList<String> Lista_Categorias() throws Exception {
        ArrayList<String> lista = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT * FROM CATE_DATA");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            lista.add(rs.getString(1));
            lista.add(rs.getString(2));
        }
        ps.close();
        objConexion.CerraConexion();
        return lista;
    }

    public boolean Modificar(Articulos objArticulos, List<String> images) throws Exception {

        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("UPDATE ARTI_DATA SET ARTI_NOM=?,ARTI_PREC=?,ARTI_CANT=?,ID_CAT=?,ARTI_FECHA_MOD=SYSDATE,ARTI_DESCRIP=?,ARTI_ESTADO=? WHERE ARTI_COD=?");
        ps.setString(1, objArticulos.getNom());
        ps.setFloat(2, objArticulos.getPrecio());
        ps.setInt(3, objArticulos.getCant());
        ps.setString(4, objArticulos.getCat());
        ps.setString(5, objArticulos.getDescrip());
        ps.setInt(6, objArticulos.getArti_estado());
        ps.setString(7, objArticulos.getCod());
        ps.executeQuery();
        ps.close();
        for(int i=1;i<images.size();i++){
        ps = objConexion.getConexion().prepareStatement("UPDATE IMG_DATA SET RUTA_IMG=? WHERE ARTI_COD = ?");
        ps.setString(2, images.get(0));
        ps.setString(1, "resourse/img/articulos/"+images.get(i));
        ps.execute();
        ps.close();
        }        
        objConexion.CerraConexion();
        return true;
    }

    public boolean Eliminar(String cod) throws Exception {

        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("UPDATE ARTI_DATA SET ARTI_ESTADO=0 WHERE ARTI_COD=?");
        ps.setString(1, cod);
        ResultSet rs = ps.executeQuery();
        ps.close();
        objConexion.CerraConexion();
        return true;
    }

    public boolean Ingresar(Articulos objArticulos, List<String> images) throws Exception {

        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("INSERT INTO ARTI_DATA VALUES ('A'||GEN_COD_ARTI.NEXTVAL,?,?,?,?,?,?,SYSDATE,NULL,1)");
        ps.setString(1, objArticulos.getNom());
        ps.setString(2, objArticulos.getDescrip());
        ps.setFloat(3, objArticulos.getPrecio());
        ps.setInt(4, objArticulos.getCant());
        ps.setString(5, objArticulos.getCat());
        ps.setLong(6, objArticulos.getPv_ruc());
        ResultSet rs = ps.executeQuery();
        ps.close();
        for(int i=1;i<images.size();i++){
        ps = objConexion.getConexion().prepareStatement("INSERT INTO IMG_DATA VALUES (?,?)");
        ps.setString(1, images.get(0));
        ps.setString(2, "resourse/img/articulos/"+images.get(i));
        ps.execute();
        ps.close();
        }
        objConexion.CerraConexion();
        return true;
    }

    public List<Articulos> ListarArticulosAdmin(String cod_arti) throws Exception {
        List<Articulos> objlista = new ArrayList();
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT ARTI_DATA.ARTI_COD,ARTI_NOM,ARTI_DESCRIP,ARTI_PREC,ARTI_CANT,ARTI_DATA.PV_RUC,PROV_DATA.PV_RAZON,TO_CHAR(ARTI_FECHA,'DD/MM/YYYY'),TO_CHAR(ARTI_FECHA_MOD,'DD/MM/YYYY'),ARTI_ESTADO FROM ARTI_DATA INNER JOIN PROV_DATA ON ARTI_DATA.PV_RUC = PROV_DATA.PV_RUC WHERE ARTI_DATA.ARTI_COD LIKE ? ORDER BY ARTI_DATA.ARTI_FECHA DESC");
        ps.setString(1,"%"+cod_arti+"%");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Articulos lista = new Articulos();
            lista.setCod(rs.getString(1));
            lista.setNom(rs.getString(2));
            lista.setDescrip(rs.getString(3));
            lista.setPrecio(rs.getFloat(4));
            lista.setCant(rs.getInt(5));
            lista.setPv_ruc(rs.getLong(6));
            lista.setNom_pv_ruc(rs.getString(7));
            lista.setF_reg(rs.getString(8));
            lista.setF_mod(rs.getString(9));
            lista.setArti_estado(rs.getInt(10));
            objlista.add(lista);
        }
        ps.close();
        objConexion.CerraConexion();
        return objlista;
    }
    
    public int UltimoCodigo() throws Exception {
        int cant=0;
        ConexionBD objConexion = new ConexionBD();
        PreparedStatement ps = objConexion.getConexion().prepareStatement("SELECT COUNT(*) FROM ARTI_DATA");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            cant=rs.getInt(1);
        }
        ps.close();
        objConexion.CerraConexion();
        return cant+1;
    }

}
