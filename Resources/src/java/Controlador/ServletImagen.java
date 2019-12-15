package Controlador;

import DAO.ListarArticulos;
import Modelo.Articulos;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

public class ServletImagen extends HttpServlet {

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
        String op = "1";
        String type = "prov";
        try {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<String> images = new ArrayList();
            List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));
            for (int i = 0; i < items.size(); i++) {
                FileItem item = items.get(i);
                if (item.isFormField()) {
                    if (item.getFieldName().equals("op")) {
                        op = item.getString();
                    }
                    if (item.getFieldName().equals("type")) {
                        type = item.getString();
                    }
                }
            }
            if (("1").equals(op)) {
                ListarArticulos objLista = new ListarArticulos();
                String Filename = "A" + objLista.UltimoCodigo();
                images.add(Filename);
                int conta = 1;
                String nom_ingre = "";
                String precio_ingre = "";
                String cant_ingre = "";
                String cate_ingre = "";
                String pv_ruc = "";
                String desc_ingre = "";
                for (int i = 0; i < items.size(); i++) {
                    FileItem item = items.get(i);
                    if (item.isFormField()) {
                        if (item.getFieldName().equals("nom_ingre")) {
                            nom_ingre =  new String(item.getString().getBytes("ISO-8859-1"), "UTF-8");
                        }
                        if (item.getFieldName().equals("precio_ingre")) {
                            precio_ingre = item.getString();
                        }
                        if (item.getFieldName().equals("cant_ingre")) {
                            cant_ingre = item.getString();
                        }
                        if (item.getFieldName().equals("cate_ingre")) {
                            cate_ingre = item.getString();
                        }
                        if (item.getFieldName().equals("pv_ruc")) {
                            pv_ruc = item.getString();
                        }
                        if (item.getFieldName().equals("desc_ingre")) {
                            desc_ingre = new String(item.getString().getBytes("ISO-8859-1"), "UTF-8");
                        }
                    } else {
                        //Obtengo datos del archivo enviado
                        String[] ext = item.getName().split("\\.");
                        String FilenameBD = Filename + "_" + conta + "." + ext[ext.length - 1];
                        images.add(FilenameBD);
                        System.out.println("Nombre del archivo:\t" + ext[ext.length - 1]);
                        System.out.println("Nombre del archivo:\t" + FilenameBD);
                        System.out.println("Tamaño del archivo:\t" + item.getSize() / 1024 + "Kb");
                        System.out.println(getServletContext().getRealPath("/"));
                        //Solo lo uso por el despliege del IDE en la carpeta build
                        String[] ruta = getServletContext().getRealPath("/").split("build");
                        /*En un servidor en linea se utiliza este codigo
                    item.write(new File(getServletContext().getContext("/")+"/img/"+nombreArchivo));*/
                        //Guardo el item en array tipo byte debido a que debo imprimirlo en archivo 2 veces
                        byte[] imagen1 = item.get();
                        byte[] imagen2 = imagen1;

                        FileOutputStream fos;
                        fos = new FileOutputStream(ruta[0] + "/web/resourse/img/articulos/" + FilenameBD);
                        fos.write(imagen1);
                        fos = new FileOutputStream(ruta[0] + "/build/web/resourse/img/articulos/" + FilenameBD);
                        fos.write(imagen2);
                        fos.close();
                        /*
                    item.write(new File(ruta[0] + "/web/resourse/img/articulos/" + FilenameBD + ".jpg"));
                    item2.write(new File(ruta[0] + "/build/web/resourse/img/articulos/" + FilenameBD + ".jpg"));
                         */
                        conta++;
                    }
                }
                Articulos objArti = new Articulos();
                objArti.setNom(nom_ingre);
                objArti.setPrecio(Float.parseFloat(precio_ingre));
                objArti.setCant(Integer.parseInt(cant_ingre));
                objArti.setCat(cate_ingre);
                objArti.setPv_ruc(Long.parseLong(pv_ruc));
                objArti.setDescrip(desc_ingre);
                objLista.Ingresar(objArti, images);
                request.setAttribute("msg", "Articulo Ingresado Correctamente");
                request.getRequestDispatcher("/dashboard_prov_v.jsp").forward(request, response);
            } else {
                int conta = 1;
                String nom_arti = "";
                String prec_arti = "";
                String cant_arti = "";
                String cate_arti = "";
                String desc_arti = "";
                String est_arti = "";
                String Filename = "";
                for (int i = 0; i < items.size(); i++) {
                    FileItem item = items.get(i);
                    if (item.isFormField()) {
                        if (item.getFieldName().equals("cod_arti")) {
                            Filename = item.getString();
                            images.add(Filename);
                        }
                        if (item.getFieldName().equals("nom_arti")) {
                            nom_arti = new String(item.getString().getBytes("ISO-8859-1"), "UTF-8");
                        }
                        if (item.getFieldName().equals("prec_arti")) {
                            prec_arti = item.getString();
                        }
                        if (item.getFieldName().equals("cant_arti")) {
                            cant_arti = item.getString();
                        }
                        if (item.getFieldName().equals("cate_arti")) {
                            cate_arti = item.getString();
                        }
                        if (item.getFieldName().equals("desc_arti")) {
                            desc_arti = new String(item.getString().getBytes("ISO-8859-1"), "UTF-8");
                        }
                        if (item.getFieldName().equals("est_arti")) {
                            est_arti = item.getString();
                        }
                    } else {
                        //Obtengo datos del archivo enviado
                        String[] ext = item.getName().split("\\.");
                        if(!ext[ext.length-1].equals("")){
                        String FilenameBD = Filename + "_" + conta + "." + ext[ext.length - 1];
                        images.add(FilenameBD);
                        System.out.println("Nombre del archivo:\t" + ext[ext.length - 1]);
                        System.out.println("Nombre del archivo:\t" + FilenameBD);
                        System.out.println("Tamaño del archivo:\t" + item.getSize() / 1024 + "Kb");
                        System.out.println(getServletContext().getRealPath("/"));
                        //Solo lo uso por el despliege del IDE en la carpeta build
                        String[] ruta = getServletContext().getRealPath("/").split("build");
                        /*En un servidor en linea se utiliza este codigo
                    item.write(new File(getServletContext().getContext("/")+"/img/"+nombreArchivo));*/
                        //Guardo el item en array tipo byte debido a que debo imprimirlo en archivo 2 veces
                        byte[] imagen1 = item.get();
                        byte[] imagen2 = imagen1;

                        FileOutputStream fos;
                        fos = new FileOutputStream(ruta[0] + "/web/resourse/img/articulos/" + FilenameBD);
                        fos.write(imagen1);
                        fos = new FileOutputStream(ruta[0] + "/build/web/resourse/img/articulos/" + FilenameBD);
                        fos.write(imagen2);
                        fos.close();
                        conta++;
                        }
                    }
                }
                Articulos objArti = new Articulos();
                objArti.setCod(Filename);
                objArti.setNom(nom_arti);
                objArti.setPrecio(Float.parseFloat(prec_arti));
                objArti.setCant(Integer.parseInt(cant_arti));
                objArti.setCat(cate_arti);
                objArti.setDescrip(desc_arti);
                objArti.setArti_estado(Integer.parseInt(est_arti));
                ListarArticulos objLista = new ListarArticulos();
                objLista.Modificar(objArti,images);
                request.setAttribute("msg", "Accion Completada");
                if (("admin").equals(type)) {
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/dashboard_prov_v.jsp").forward(request, response);
                }
            }
        } catch (Exception ex) {
            if (("prov").equals(type)) {
                request.setAttribute("error", ex);
                request.getRequestDispatcher("/dashboard_prov_v.jsp").forward(request, response);
            } else {
                request.setAttribute("error", ex);
                request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
            }
            Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
