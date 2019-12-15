
package Modelo;

public class CarritoCompras extends Articulos{
    private int Cant;
    private Float Prec;
    private Float Total;

    public int getCant() {
        return Cant;
    }

    public void setCant(int Cant) {
        this.Cant = Cant;
    }

    public Float getPrec() {
        return Prec;
    }

    public void setPrec(Float Prec) {
        this.Prec = Prec;
    }

    public Float getTotal() {
        return Total;
    }

    public void setTotal(Float Total) {
        this.Total = Total;
    }

}
