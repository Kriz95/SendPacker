

package Modelo;


public class Envios {
    private String Cventa;
    private String Carti;
    private String articulo;
    private int cant;
    private Long pv_ruc;
    private String razon;
    private int estado;
    private int dni;
    private String nom;
    private float lat;
    private float lon;
    private String fecha;
    private Long pv_ruc_envio;

    public Long getPv_ruc_envio() {
        return pv_ruc_envio;
    }

    public void setPv_ruc_envio(Long pv_ruc_envio) {
        this.pv_ruc_envio = pv_ruc_envio;
    }

    public String getArticulo() {
        return articulo;
    }

    public void setArticulo(String articulo) {
        this.articulo = articulo;
    }

    public Long getPv_ruc() {
        return pv_ruc;
    }

    public void setPv_ruc(Long pv_ruc) {
        this.pv_ruc = pv_ruc;
    }

    public String getRazon() {
        return razon;
    }

    public void setRazon(String razon) {
        this.razon = razon;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public int getDni() {
        return dni;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public float getLat() {
        return lat;
    }

    public void setLat(float lat) {
        this.lat = lat;
    }

    public float getLon() {
        return lon;
    }

    public void setLon(float lon) {
        this.lon = lon;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getCventa() {
        return Cventa;
    }

    public void setCventa(String Cventa) {
        this.Cventa = Cventa;
    }

    public int getCant() {
        return cant;
    }

    public void setCant(int cant) {
        this.cant = cant;
    }

    public String getCarti() {
        return Carti;
    }

    public void setCarti(String Carti) {
        this.Carti = Carti;
    }
    
    
    
}
