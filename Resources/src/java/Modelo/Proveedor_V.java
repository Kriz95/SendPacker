package Modelo;

public class Proveedor_V {
    private Long Ruc;
    private String Razon;
    private String Direccion;
    private String Contacto;
    private int NContacto;
    private String Lati;
    private String Long;
    private String Email;
    private int Cel;
    private int Estado;
    private String Pass;
    private int Tipo;
    private String f_reg;
    private String f_mod;
    
    public Proveedor_V() {
     
    }

    public int getEstado() {
        return Estado;
    }

    public void setEstado(int Estado) {
        this.Estado = Estado;
    }

    public Long getRuc() {
        return Ruc;
    }

    public void setRuc(Long Ruc) {
        this.Ruc = Ruc;
    }

    public String getRazon() {
        return Razon;
    }

    public void setRazon(String Razon) {
        this.Razon = Razon;
    }

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String Direccion) {
        this.Direccion = Direccion;
    }

    public String getContacto() {
        return Contacto;
    }

    public void setContacto(String Contacto) {
        this.Contacto = Contacto;
    }

    public int getNContacto() {
        return NContacto;
    }

    public void setNContacto(int NContacto) {
        this.NContacto = NContacto;
    }

    public String getLati() {
        return Lati;
    }

    public void setLati(String Lati) {
        this.Lati = Lati;
    }

    public String getLong() {
        return Long;
    }

    public void setLong(String Long) {
        this.Long = Long;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public int getCel() {
        return Cel;
    }

    public void setCel(int Cel) {
        this.Cel = Cel;
    }
    
    public String getPass(){
        return Pass;
    }
    
    public void setPass(String Pass){
        this.Pass = Pass;
    }
    
     public int getTipo(){
        return Tipo;
    }
    
    public void setTipo(int Tipo){
        this.Tipo = Tipo;
    }

    public String getF_reg() {
        return f_reg;
    }

    public String getF_mod() {
        return f_mod;
    }

    public void setF_reg(String f_reg) {
        this.f_reg = f_reg;
    }

    public void setF_mod(String f_mod) {
        this.f_mod = f_mod;
    }

}
