package Controlador;

import DAO.ListarArticulos;
import Modelo.Articulos;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.simple.JSONObject;


@WebServlet(name = "ServletMarket", urlPatterns = {"/ServletMarket"})
public class ServletMarket extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");
        switch (Integer.parseInt(op)) {
            case 1: {
                try {
                    //Detalles de Articulo
                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    JSONObject JSON = new JSONObject();
                    String Codarti = request.getParameter("codarti");
                    ListarArticulos objListArti = new ListarArticulos();
                    Articulos objArticulo = objListArti.BuscarArticulo(Codarti);
                    String img = "<img class='img-fluid' src='"+objArticulo.getRutaimg()+"'>";
                    String title = "<h4>"+objArticulo.getNom()+"</h4>";
                    String cod = "<p>Cod. de Articulo: "+objArticulo.getCod()+"</p><input type='hidden' name='codarti' value='"+objArticulo.getCod()+"'>";
                    String desc = objArticulo.getDescrip();
                    String prec = "<h4>S/ "+objArticulo.getPrecio()+"</h4><input type='hidden' id='artiprec' value='"+objArticulo.getPrecio()+"'/>";
                    JSON.put("img",img);
                    JSON.put("title",title);
                    JSON.put("cod",cod);
                    JSON.put("prec",prec);
                    JSON.put("desc",desc);
                    out.print(JSON);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                break;
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
