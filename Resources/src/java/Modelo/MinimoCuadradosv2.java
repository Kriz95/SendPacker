package Modelo;

import DAO.DatoEstadistica;
import java.util.ArrayList;
import java.util.List;

public class MinimoCuadradosv2 {

    public List<String> MinimosCuadrados(double[][] data, String cod_arti) throws Exception {
        double[][] dataC = ComprobarDatos(data);
        double[][] tabla = PrepararTabla(dataC);
        double predic[] = Prediccion(tabla, 3);
        return PrepareJSON(dataC, predic, cod_arti);

    }

    private List<String> PrepareJSON(double[][] data, double[] predic, String cod_arti) {
        int n = data.length;
        int cantpredic = predic.length;
        String[][] ReadyJSON = new String[n + cantpredic][3];
        for (int i = 0; i < data.length; i++) {
            ReadyJSON[i][0] = String.valueOf(data[i][0]);
            ReadyJSON[i][1] = String.valueOf(data[i][1]);
            ReadyJSON[i][2] = String.valueOf(data[i][2]);
        }
        for (int i = 0; i < cantpredic; i++) {
            double mes = data[n - 1][0];
            double año = data[n - 1][1];
            double aux1 = mes + (i + 1);
            if (aux1 > 12) {
                mes = 1;
                año = año + 1;
            } else {
                mes = aux1;
            }
            ReadyJSON[n + i][0] = String.valueOf(mes);
            ReadyJSON[n + i][1] = String.valueOf(año);
            ReadyJSON[n + i][2] = String.valueOf(predic[i]);
        }
        //Transformar numeros de meses a nombres
        for (int i = 0; i < ReadyJSON.length; i++) {
            switch (ReadyJSON[i][0]) {
                case "1.0": {
                    ReadyJSON[i][0] = "Enero";
                    break;
                }
                case "2.0": {
                    ReadyJSON[i][0] = "Febrero";
                    break;
                }
                case "3.0": {
                    ReadyJSON[i][0] = "Marzo";
                    break;
                }
                case "4.0": {
                    ReadyJSON[i][0] = "Abril";
                    break;
                }
                case "5.0": {
                    ReadyJSON[i][0] = "Mayo";
                    break;
                }
                case "6.0": {
                    ReadyJSON[i][0] = "Junio";
                    break;
                }
                case "7.0": {
                    ReadyJSON[i][0] = "Julio";
                    break;
                }
                case "8.0": {
                    ReadyJSON[i][0] = "Agosto";
                    break;
                }
                case "9.0": {
                    ReadyJSON[i][0] = "Septiembre";
                    break;
                }
                case "10.0": {
                    ReadyJSON[i][0] = "Octubre";
                    break;
                }
                case "11.0": {
                    ReadyJSON[i][0] = "Noviembre";
                    break;
                }
                case "12.0": {
                    ReadyJSON[i][0] = "Diciembre";
                    break;
                }
            }
        }
        List<String> objReadyList = new ArrayList();
        for (int i = 0; i < ReadyJSON.length; i++) {
            objReadyList.add(cod_arti);
            objReadyList.add(ReadyJSON[i][0]);
            objReadyList.add(ReadyJSON[i][1]);
            objReadyList.add(ReadyJSON[i][2]);
        }

        return objReadyList;
    }

    private double[][] PrepararTabla(double[][] Data) {
        //Hallar Numero de Meses
        int n = Data.length;
        double objTabla[][] = new double[n + 1][7];
        //Rellenar tabla
        for (int i = 0; i < n; i++) {
            objTabla[i][0] = Data[i][0];
            objTabla[i][1] = Data[i][1];
            objTabla[i][2] = i + 1;
            objTabla[i][3] = Data[i][2];
            objTabla[i][4] = objTabla[i][2] * objTabla[i][2];
            objTabla[i][5] = objTabla[i][3] * objTabla[i][3];
            objTabla[i][6] = objTabla[i][2] * objTabla[i][3];
        }
        //Sumar Resultados
        int x = 0;
        double total1 = 0, total2 = 0, total3 = 0, total4 = 0, total5 = 0;
        while (x != n) {
            total1 = total1 + objTabla[x][2];
            total2 = total2 + objTabla[x][3];
            total3 = total3 + objTabla[x][4];
            total4 = total4 + objTabla[x][5];
            total5 = total5 + objTabla[x][6];
            x++;
        }
        objTabla[n][2] = total1;
        objTabla[n][3] = total2;
        objTabla[n][4] = total3;
        objTabla[n][5] = total4;
        objTabla[n][6] = total5;
        return objTabla;
    }

    private double CalculoA(double[][] objTabla, double b) {
        int n = objTabla.length - 1;

        double aux1 = (objTabla[n][3]) - (b * objTabla[n][2]);
        double aux2 = (n);
        double a = aux1 / aux2;

        return a;
    }

    private double CalculoB(double[][] objTabla) {
        int n = objTabla.length - 1;

        double aux1 = (n * objTabla[n][6]) - (objTabla[n][2] * objTabla[n][3]);
        double aux2 = (n * objTabla[n][4]) - (objTabla[n][2] * objTabla[n][2]);
        double b = aux1 / aux2;

        return b;
    }

    private double CalculoC(double[][] objTabla, double b) {
        int n = objTabla.length - 1;

        double aux1 = (b * n + 1);
        double aux2 = (objTabla[n][3]);
        double c = aux1 / aux2;
        return c;

    }

    private double[] Prediccion(double[][] objTabla, int npredic) {
        int n = objTabla.length;
        double b = CalculoB(objTabla);
        double a = CalculoA(objTabla, b);
        double c = CalculoC(objTabla, b);
        double[] predic = new double[npredic];
        for (int i = 0; i < npredic; i++) {
            predic[i] = a + (b * (n + i));

        }
        return predic;

    }

    private double[][] ComprobarDatos(double[][] data) throws Exception {
        DatoEstadistica objDatoE = new DatoEstadistica();

        int[] rango = objDatoE.RangeDate(5);
        int mes = rango[0];
        int año = rango[1];
        int aux1 = rango[0] - data.length;
        if (aux1 < 0) {
            for (int i = 0; i < data.length; i++) {
                if (data[i][0] != (mes + i)) {

                    for (int j = data.length - 1; j != i; j--) {
                        data[j][0] = data[j - 1][0];
                        data[j][1] = data[j - 1][1];
                        data[j][2] = data[j - 1][2];
                    }
                    data[i][0] = (mes + i);
                    data[i][1] = año;
                    data[i][2] = 0;
                }

            }
        } else {
            mes = 12 - aux1;
            for (int i = 0; i < data.length; i++) {
                System.out.println(data[i][0] + " " + (mes + i));
                if (data[i][0] != (mes + i) || data[i][1] != año) {

                    for (int j = data.length - 1; j != i; j--) {
                        data[j][0] = data[j - 1][0];
                        data[j][1] = data[j - 1][1];
                        data[j][2] = data[j - 1][2];
                    }
                    if (mes + i > 12) {
                        data[i][0] = (1 + i);
                        data[i][1] = (año + 1);
                        data[i][2] = 0;
                    } else {
                        data[i][0] = (mes);
                        data[i][1] = (año);
                        data[i][2] = 0;
                    }

                }

            }
        }

        return data;
    }

}
