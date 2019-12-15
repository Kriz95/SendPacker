package Controlador;

import Modelo.IngresosPV;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.data.general.DefaultPieDataset;

@WebServlet(name = "EstadisticoPie", urlPatterns = {"/EstadisticoPie"})
public class EstadisticoPie extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("image/jpeg");
        HttpSession Session = request.getSession(false);
        ArrayList<IngresosPV> listaIngreso = (ArrayList<IngresosPV>)Session.getAttribute("IngresosMes");

        float n1 = 0, n2 = 0, n3 = 0, n4 = 0, n5 = 0, n6 = 0, n7 = 0, n8 = 0, n9 = 0, n10 = 0, n11 = 0, n12 = 0;
        for (int i = 0; i < listaIngreso.size(); i++) {
            if (listaIngreso.get(i).getFecha().equals("1")) {
                float numEntero = listaIngreso.get(i).getMonto();
                n1 = n1 + numEntero;
            } else {
                if (listaIngreso.get(i).getFecha().equals("2")) {
                    float numEntero = listaIngreso.get(i).getMonto();
                    n2 = n2 + numEntero;
                } else {
                    if (listaIngreso.get(i).getFecha().equals("3")) {
                        float numEntero = listaIngreso.get(i).getMonto();
                        n3 = n3 + numEntero;
                    } else {
                        if (listaIngreso.get(i).getFecha().equals("4")) {
                            float numEntero = listaIngreso.get(i).getMonto();
                            n4 = n4 + numEntero;
                        } else {
                            if (listaIngreso.get(i).getFecha().equals("5")) {
                                float numEntero = listaIngreso.get(i).getMonto();
                                n5 = n5 + numEntero;
                            } else {
                                if (listaIngreso.get(i).getFecha().equals("6")) {
                                    float numEntero = listaIngreso.get(i).getMonto();
                                    n6 = n6 + numEntero;
                                } else {
                                    if (listaIngreso.get(i).getFecha().equals("7")) {
                                        float numEntero = listaIngreso.get(i).getMonto();
                                        n7 = n7 + numEntero;
                                    } else {
                                        if (listaIngreso.get(i).getFecha().equals("8")) {
                                            float numEntero = listaIngreso.get(i).getMonto();
                                            n8 = n8 + numEntero;
                                        } else {
                                            if (listaIngreso.get(i).getFecha().equals("9")) {
                                                float numEntero = listaIngreso.get(i).getMonto();
                                                n9 = n9 + numEntero;
                                            } else {
                                                if (listaIngreso.get(i).getFecha().equals("10")) {
                                                    float numEntero = listaIngreso.get(i).getMonto();
                                                    n10 = 10 + numEntero;
                                                } else {
                                                    if (listaIngreso.get(i).getFecha().equals("11")) {
                                                        float numEntero = listaIngreso.get(i).getMonto();
                                                        n11 = n11 + numEntero;
                                                    } else {
                                                        if (listaIngreso.get(i).getFecha().equals("12")) {
                                                            float numEntero = listaIngreso.get(i).getMonto();
                                                            n12 = n12 + numEntero;
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

        }
//Espacio- Inicio de Grafico
        //INSTANCIA QUE CORRESPONDE AL TIPO DE GRAFICO
        //CARGAREMOS LA DATA PARA LAS SERIES
        DefaultPieDataset data = new DefaultPieDataset();

        double tot = (n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8 + n9 + n10 + n11 + n12);
        double ps1 = (n1 * 100) / tot;
        double ps2 = (n2 * 100) / tot;
        double ps3 = (n3 * 100) / tot;
        double ps4 = (n4 * 100) / tot;
        double ps5 = (n5 * 100) / tot;
        double ps6 = (n6 * 100) / tot;
        double ps7 = (n7 * 100) / tot;
        double ps8 = (n8 * 100) / tot;
        double ps9 = (n9 * 100) / tot;
        double ps10 = (n10 * 100) / tot;
        double ps11 = (n11 * 100) / tot;
        double ps12 = (n12 * 100) / tot;
        String p1 = String.format("%.2f", ps1);
        String p2 = String.format("%.2f", ps2);
        String p3 = String.format("%.2f", ps3);
        String p4 = String.format("%.2f", ps4);
        String p5 = String.format("%.2f", ps5);
        String p6 = String.format("%.2f", ps6);
        String p7 = String.format("%.2f", ps7);
        String p8 = String.format("%.2f", ps8);
        String p9 = String.format("%.2f", ps9);
        String p10 = String.format("%.2f", ps10);
        String p11 = String.format("%.2f", ps11);
        String p12 = String.format("%.2f", ps12);
        data.setValue("Enero: " + p1 + "%", n1);
        data.setValue("Febrero: " + p2 + "%", n2);
        data.setValue("Marzo: " + p3 + "%", n3);
        data.setValue("Abril: " + p4 + "%", n4);
        data.setValue("Mayo: " + p5 + "%", n5);
        data.setValue("Junio: " + p6 + "%", n6);
        data.setValue("Julio: " + p7 + "%", n7);
        data.setValue("Agosto: " + p8 + "%", n8);
        data.setValue("Setiembre: " + p9 + "%", n9);
        data.setValue("Octubre: " + p10 + "%", n10);
        data.setValue("Noviembre: " + p11 + "%", n11);
        data.setValue("Diciembre: " + p12 + "%", n12);
        //datas.setValue(n1,"Ingreso","Ene.");
        //datas.setValue(n2,"Ingreso","Feb.");
        //datas.setValue(n3,"Ingreso","Mar.");
        //datas.setValue(n4,"Ingreso","Abr.");
        //datas.setValue(n5,"Ingreso","May.");
        //datas.setValue(n6,"Ingreso","Jun.");
        //datas.setValue(n7,"Ingreso","Jul.");
        //datas.setValue(n8,"Ingreso","Ago.");
        //datas.setValue(n9,"Ingreso","Set.");
        //datas.setValue(n10,"Ingreso","Oct.");
        //datas.setValue(n11,"Ingreso","Nov.");
        //datas.setValue(n12,"Ingreso","Dic.");
        //GENERAR EL GRAFICO
        JFreeChart grafico = ChartFactory.createPieChart("Ingresos obtenidos " + Session.getAttribute("AñoIngreso"), data, true, true, true);
        //JFreeChart graficos = ChartFactory.createBarChart("Ingresos obtenidos "+request.getAttribute, "Meses", "Promedio", datas,PlotOrientation.VERTICAL,true,true,true);

        //MEDIO DONDE SE VISUALIZARA EL GRADICO
        //response.setContentType("image/JPEG");
        OutputStream sa = response.getOutputStream();
        //IMPRESION DEL GRAFICO
        ChartUtilities.writeChartAsJPEG(sa, grafico, 600, 600);

        //ChartUtilities.writeChartAsJPEG(sa, graficos, 500, 500);
        //ChartUtilities.saveChartAsJPEG(new File("C:/Users/Administrador/Desktop/SendPacker/web/graficas/grafica.jpeg"), grafico, 600, 600);
        /*
            RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/estadistica.jsp");
            dispatcher.forward(request, response);
         */
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
