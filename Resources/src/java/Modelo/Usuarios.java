
package Modelo;

public class Usuarios {
    private Long DNI;
    private String Nombres;
    private String ApelPaterno;
    private String ApelMaterno;
    private String Email;
    private int Cel;
    private String pass;
    private int estado;
    private String f_reg;
    private String f_mod;
   

    public Usuarios() {
        
    }

    public Long getDNI() {
        return DNI;
    }

    public void setDNI(Long DNI) {
        this.DNI = DNI;
    }

    public String getNombres() {
        return Nombres;
    }

    public void setNombres(String Nombres) {
        this.Nombres = Nombres;
    }

    public String getApelPaterno() {
        return ApelPaterno;
    }

    public void setApelPaterno(String ApelPaterno) {
        this.ApelPaterno = ApelPaterno;
    }

    public String getApelMaterno() {
        return ApelMaterno;
    }

    public void setApelMaterno(String ApelMaterno) {
        this.ApelMaterno = ApelMaterno;
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

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
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
