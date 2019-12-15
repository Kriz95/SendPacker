
package Modelo;

public class Articulos {
    private String cod;
    private String nom;
    private String descrip;
    private float precio;
    private int cant;
    private String cat;
    private String ncat;
    private Long pv_ruc;
    private String nom_pv_ruc;
    private String f_reg;
    private String f_mod;
    private String rutaimg;
    private int arti_estado;

    public String getNom_pv_ruc() {
        return nom_pv_ruc;
    }

    public void setNom_pv_ruc(String nom_pv_ruc) {
        this.nom_pv_ruc = nom_pv_ruc;
    }

    public int getArti_estado() {
        return arti_estado;
    }

    public void setArti_estado(int arti_estado) {
        this.arti_estado = arti_estado;
    }

    public String getCod() {
        return cod;
    }

    public void setCod(String cod) {
        this.cod = cod;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public float getPrecio() {
        return precio;
    }

    public void setPrecio(float precio) {
        this.precio = precio;
    }

    public int getCant() {
        return cant;
    }

    public void setCant(int cant) {
        this.cant = cant;
    }

    public Long getPv_ruc() {
        return pv_ruc;
    }

    public void setPv_ruc(Long pv_ruc) {
        this.pv_ruc = pv_ruc;
    }

    public String getCat() {
        return cat;
    }

    public void setCat(String cat) {
        this.cat = cat;
    }

    public String getNcat() {
        return ncat;
    }

    public void setNcat(String ncat) {
        this.ncat = ncat;
    }

    public String getF_reg() {
        return f_reg;
    }

    public void setF_reg(String f_reg) {
        this.f_reg = f_reg;
    }

    public String getF_mod() {
        return f_mod;
    }

    public void setF_mod(String f_mod) {
        this.f_mod = f_mod;
    }

    public String getDescrip() {
        return descrip;
    }

    public void setDescrip(String descrip) {
        this.descrip = descrip;
    }

    public String getRutaimg() {
        return rutaimg;
    }

    public void setRutaimg(String rutaimg) {
        this.rutaimg = rutaimg;
    }
    
}
