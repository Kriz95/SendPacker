package Controlador;

import DAO.DatoEstadistica;
import Modelo.MinimoCuadradosv2;
import Modelo.Proveedor_V;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;

@WebServlet(name = "ServletEstadistica", urlPatterns = {"/ServletEstadistica"})
public class ServletEstadistica extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        switch (Integer.parseInt(op)) {
            case 1: {
                HttpSession Session = request.getSession(false);
                Proveedor_V objProv = (Proveedor_V) Session.getAttribute("usuario");
                int año = Integer.parseInt(request.getParameter("select"));
                String ruc = String.valueOf(objProv.getRuc());
                DatoEstadistica objEsta = new DatoEstadistica();
                try {
                    Session.setAttribute("IngresosMes", objEsta.ListaIngresosMeses(ruc, año));
                    Session.setAttribute("AñoIngreso", año);
                    RequestDispatcher rd = request.getRequestDispatcher("jsp/estadistica.jsp");
                    rd.forward(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(ServletEstadistica.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 2: {
                HttpSession Session = request.getSession(false);
                Proveedor_V objProv = (Proveedor_V) Session.getAttribute("usuario");
                String ruc = String.valueOf(objProv.getRuc());
                DatoEstadistica objEsta = new DatoEstadistica();
                try {
                    Session.setAttribute("IngresosAño", objEsta.ListaIngresosAños(ruc));
                    RequestDispatcher rd = request.getRequestDispatcher("jsp/estadisticatodo.jsp");
                    rd.forward(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(ServletEstadistica.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 3: {

                RequestDispatcher rd = request.getRequestDispatcher("/dashboard_prov_v.jsp");
                rd.forward(request, response);

                break;
            }

            case 4: {
                //Data para Grafica JS Pronostico
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                JSONObject objJSONObject = new JSONObject();
                HttpSession Session = request.getSession(false);
                Proveedor_V objProv = (Proveedor_V) Session.getAttribute("usuario");
                DatoEstadistica objDatoE = new DatoEstadistica();
                try {
                    List<String> objlistRank5 = objDatoE.ListaTop5Articulos(objProv.getRuc());
                    MinimoCuadradosv2 objMiniCuad2 = new MinimoCuadradosv2();
                    List<List<String>> objDataPredic = new ArrayList();
                    for(int i= 0; i<objlistRank5.size();i++){
                        double data [][] = objDatoE.TotalporArticulo(objProv.getRuc(),objlistRank5.get(i));
                        objDataPredic.add(objMiniCuad2.MinimosCuadrados(data,objlistRank5.get(i))); 
                    }                   
                    objJSONObject.put("dataChart",objDataPredic);
                    out.print(objJSONObject);
                } catch (Exception ex) {
                    out.print(ex);
                    Logger.getLogger(ServletEstadistica.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;
            }

        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
