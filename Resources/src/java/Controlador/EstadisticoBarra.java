package Controlador;

import Modelo.TotalAños;
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
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;


@WebServlet(name = "EstadisticoBarra", urlPatterns = {"/EstadisticoBarra"})
public class EstadisticoBarra extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("image/JPEG");
        HttpSession Session = request.getSession();
        DefaultCategoryDataset datas = new DefaultCategoryDataset();

        ArrayList<TotalAños> listaTotal = (ArrayList<TotalAños>) Session.getAttribute("IngresosAño");

        
        String ns;
        float n=0;
        int ns1;
        int p=0;
        int inicio = 0;
        for (int i = 0; i < listaTotal.size(); i++) {
            n = n+listaTotal.get(i).getTotal();
            ns = listaTotal.get(i).getYear();
            ns1 = Integer.parseInt(listaTotal.get(i).getYear());
            datas.setValue(n, "Ingreso", "" + ns);
            if (i == 0) {
                inicio = ns1;
                p = listaTotal.size() - 1;
            }

        }

        //GENERAR EL GRAFICO
        //JFreeChart grafico = ChartFactory.createPieChart("Ingresos obtenidos "+request.getAttribute("atiempo"), data, true, true, true);
        JFreeChart graficos = ChartFactory.createBarChart("Ingresos obtenidos (" + inicio + " - " + (inicio + p) + ")", "AÑO", "PROMEDIO", datas, PlotOrientation.VERTICAL, true, true, true);

        //MEDIO DONDE SE VISUALIZARA EL GRADICO
        try {

            OutputStream sa = null;
            sa = response.getOutputStream();

            //IMPRESION DEL GRAFICO
            //ChartUtilities.writeChartAsJPEG(sa, grafico, 500, 500);
            ChartUtilities.writeChartAsJPEG(sa, graficos, 600, 600);

            //ChartUtilities.saveChartAsJPEG(new File("C:/xampp/htdocs/gift/web/graficatodo/graficas.jpeg"), grafico, 500, 500);
        } catch (Exception e) {

        }

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
