package Modelo;

public class Ventas {
    private String codv;
    private String Fechav;
    private int DNI;
    private String NDNI;
    private Float TotalV;
    private Float LatV;
    private Float LongV;
    private int EstadoV;

    public String getCodv() {
        return codv;
    }

    public void setCodv(String codv) {
        this.codv = codv;
    }

    public String getFechav() {
        return Fechav;
    }

    public void setFechav(String fechav) {
        Fechav = fechav;
    }

    public int getDNI() {
        return DNI;
    }

    public void setDNI(int DNI) {
        this.DNI = DNI;
    }

    public String getNDNI() {
        return NDNI;
    }

    public void setNDNI(String NDNI) {
        this.NDNI = NDNI;
    }

    public Float getTotalV() {
        return TotalV;
    }

    public void setTotalV(Float totalV) {
        TotalV = totalV;
    }

    public Float getLatV() {
        return LatV;
    }

    public void setLatV(Float latV) {
        LatV = latV;
    }

    public Float getLongV() {
        return LongV;
    }

    public void setLongV(Float longV) {
        LongV = longV;
    }

    public int getEstadoV() {
        return EstadoV;
    }

    public void setEstadoV(int estadoV) {
        EstadoV = estadoV;
    }
}
