package Controlador;

import DAO.*;
import Modelo.*;

import java.io.IOException;
import java.io.*;
import java.sql.SQLIntegrityConstraintViolationException;
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

@WebServlet(name = "ValLogin", urlPatterns = {"/ValLogin"})
public class Servlet1 extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");

        switch (Integer.parseInt(op)) {
            case 0: {
                //Inicio Session

                String ruc = request.getParameter("prov_ruc");
                String pass = request.getParameter("pass");
                HttpSession Session = request.getSession();
                ValLoginImp objValidar = new ValLoginImp();
                try {
                    if (objValidar.ValLoginProv(ruc, pass)) {
                        ListarProv objListarProv = new ListarProv();
                        int Tipo = objValidar.ValLoginProv(ruc);
                        if (Tipo == 0) {
                            // Admin
                            Session.setAttribute("usuario", objListarProv.BuscarProv_V(ruc));
                            RequestDispatcher rs = request.getRequestDispatcher("/dashboard_admin.jsp");
                            rs.forward(request, response);
                        } else {
                            if (Tipo == 2) {
                                //Prov Envios
                                Session.setAttribute("usuario", objListarProv.BuscarProv_E(ruc));
                                RequestDispatcher rs = request.getRequestDispatcher("/dashboard_prov_e.jsp");
                                rs.forward(request, response);
                            } else {
                                //Prov Ventas
                                Session.setAttribute("usuario", objListarProv.BuscarProv_V(ruc));
                                RequestDispatcher rs = request.getRequestDispatcher("/dashboard_prov_v.jsp");
                                rs.forward(request, response);
                            }
                        }

                    } else {
                        request.setAttribute("error", "Datos Ingresados Incorrectos");
                        RequestDispatcher rs = request.getRequestDispatcher("/login_prov.jsp");
                        rs.forward(request, response);
                    }

                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/login_prov.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;
            }
            case 1: {
                //Cerrar Sesion
                response.setHeader("Cache-Control", "no-cache");
                response.setHeader("Pragma", "no-cache");
                response.setDateHeader("Expires", 0);
                HttpSession Session = request.getSession(false);
                Session.removeAttribute("usuario");
                Session.invalidate();
                response.sendRedirect("login_prov.jsp");
                break;
            }
            case 2: {
                //Registro Proveedores
                ListarProv listaprov = new ListarProv();
                int tprov;
                tprov = Integer.parseInt(request.getParameter("tprov"));
                if (tprov == 2) {
                    Proveedor_E objprov = new Proveedor_E();
                    objprov.setRuc(Long.parseLong(request.getParameter("prov_ruc")));
                    objprov.setRazon(new String(request.getParameter("prov_razon").getBytes("ISO-8859-1"), "UTF-8"));
                    objprov.setDireccion(new String(request.getParameter("prov_dire").getBytes("ISO-8859-1"), "UTF-8"));
                    objprov.setContacto(request.getParameter("prov_contac"));
                    objprov.setNContacto(Integer.parseInt(request.getParameter("prov_contac_num")));
                    objprov.setLong(request.getParameter("prov_Long"));
                    objprov.setLati(request.getParameter("prov_Lat"));
                    objprov.setEmail(request.getParameter("email"));
                    objprov.setPass(request.getParameter("password"));
                    objprov.setHini(request.getParameter("prov_hini"));
                    objprov.setHfin(request.getParameter("prov_hfin"));
                    objprov.setTipo(Integer.parseInt(request.getParameter("tprov")));
                    try {
                        listaprov.IngresarProv_E(objprov);
                        request.setAttribute("msg", "Registro Completado");
                        request.getRequestDispatcher("login_prov.jsp").forward(request, response);
                    } catch (SQLIntegrityConstraintViolationException ex1) {
                        request.setAttribute("error", "El Proveedor ya se encuentra registrado");
                        request.getRequestDispatcher("registroProv.jsp").forward(request, response);
                        Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex1);
                    } catch (Exception ex) {
                        request.setAttribute("error", ex);
                        request.getRequestDispatcher("registroProv.jsp").forward(request, response);
                        Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                    }
                } else {
                    Proveedor_V objprov = new Proveedor_V();
                    objprov.setRuc(Long.parseLong(request.getParameter("prov_ruc")));
                    objprov.setRazon(new String(request.getParameter("prov_razon").getBytes("ISO-8859-1"), "UTF-8"));
                    objprov.setDireccion(new String(request.getParameter("prov_dire").getBytes("ISO-8859-1"), "UTF-8"));
                    objprov.setContacto(request.getParameter("prov_contac"));
                    objprov.setNContacto(Integer.parseInt(request.getParameter("prov_contac_num")));
                    objprov.setLong(request.getParameter("prov_Long"));
                    objprov.setLati(request.getParameter("prov_Lat"));
                    objprov.setEmail(request.getParameter("email"));
                    objprov.setPass(request.getParameter("password"));
                    objprov.setTipo(Integer.parseInt(request.getParameter("tprov")));
                    try {
                        listaprov.IngresarProv_V(objprov);
                        request.setAttribute("msg", "Registro Completado");
                        request.getRequestDispatcher("login_prov.jsp").forward(request, response);
                    } catch (SQLIntegrityConstraintViolationException ex1) {
                        request.setAttribute("error", "El Proveedor ya se encuentra registrado");
                        request.getRequestDispatcher("registroProv.jsp").forward(request, response);
                        Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex1);
                    } catch (Exception ex) {
                        request.setAttribute("error", ex);
                        request.getRequestDispatcher("registroProv.jsp").forward(request, response);
                        Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                    }

                }
                break;
            }
            case 3: {
                //Consulta Envios Especifico
                try {
                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    Envios objEnvios = new Envios();
                    JSONObject objJSONObject = new JSONObject();
                    objEnvios.setCventa(request.getParameter("venta"));
                    objEnvios.setCarti(request.getParameter("arti"));
                    ListarEnvios objLista = new ListarEnvios();
                    ListarProv objListaProv = new ListarProv();
                    String pvruc = String.valueOf(objLista.BuscarEnvio(objEnvios).getPv_ruc());
                    objJSONObject.put("arti", objLista.BuscarEnvio(objEnvios).getArticulo());
                    objJSONObject.put("cant", objLista.BuscarEnvio(objEnvios).getCant());
                    objJSONObject.put("dni", objLista.BuscarEnvio(objEnvios).getDni());
                    objJSONObject.put("nom", objLista.BuscarEnvio(objEnvios).getNom());
                    objJSONObject.put("ruc", pvruc);
                    objJSONObject.put("fecha", objLista.BuscarEnvio(objEnvios).getFecha());
                    objJSONObject.put("razon", objLista.BuscarEnvio(objEnvios).getRazon());
                    objJSONObject.put("long_e", objLista.BuscarEnvio(objEnvios).getLon());
                    objJSONObject.put("lat_e", objLista.BuscarEnvio(objEnvios).getLat());
                    objJSONObject.put("long_p", objListaProv.BuscarProv_V(pvruc).getLong());
                    objJSONObject.put("lat_p", objListaProv.BuscarProv_V(pvruc).getLati());
                    out.print(objJSONObject);
                    out.close();
                } catch (Exception ex) {
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }

            case 4: {
                //Consulta Prov V           
                try {

                    response.setContentType("application/json");
                    String ruc = (String) request.getParameter("ruc");
                    ListarProv objProv_V = new ListarProv();
                    objProv_V.BuscarProv_V(ruc);
                    JSONObject objJSONObject = new JSONObject();
                    PrintWriter out = response.getWriter();
                    objJSONObject.put("ruc", objProv_V.BuscarProv_V(ruc).getRuc());
                    objJSONObject.put("razon", objProv_V.BuscarProv_V(ruc).getRazon());
                    objJSONObject.put("direccion", objProv_V.BuscarProv_V(ruc).getDireccion());
                    objJSONObject.put("email", objProv_V.BuscarProv_V(ruc).getEmail());
                    objJSONObject.put("cont", objProv_V.BuscarProv_V(ruc).getContacto());
                    objJSONObject.put("ncont", objProv_V.BuscarProv_V(ruc).getNContacto());
                    objJSONObject.put("lon", objProv_V.BuscarProv_V(ruc).getLong());
                    objJSONObject.put("lat", objProv_V.BuscarProv_V(ruc).getLati());
                    objJSONObject.put("est", objProv_V.BuscarProv_V(ruc).getEstado());
                    out.print(objJSONObject);
                    out.close();
                } catch (Exception ex) {
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 5: {
                //Eliminar Prov V     
                try {
                    String ruc = request.getParameter("iruc");
                    ListarProv objProv = new ListarProv();
                    objProv.EliminarProv(ruc);
                    request.setAttribute("msg", "Accion Completada");
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;
            }
            case 6: {
                //Modificar Prov V      
                try {
                    response.setContentType("application/json");
                    Proveedor_V objProveedor_V = new Proveedor_V();
                    objProveedor_V.setRuc(Long.parseLong(request.getParameter("ruc_v")));
                    objProveedor_V.setRazon(new String(request.getParameter("razon_v").getBytes("ISO-8859-1"), "UTF-8"));
                    objProveedor_V.setDireccion(new String(request.getParameter("direc_v").getBytes("ISO-8859-1"), "UTF-8"));
                    objProveedor_V.setEmail(request.getParameter("email_v"));
                    objProveedor_V.setContacto(request.getParameter("cont_v"));
                    objProveedor_V.setNContacto(Integer.parseInt(request.getParameter("ncont_v")));
                    objProveedor_V.setLong(request.getParameter("long_v"));
                    objProveedor_V.setLati(request.getParameter("lat_v"));
                    if ((request.getParameter("type").equals("prov"))) {
                        objProveedor_V.setEstado(1);
                    } else {
                        objProveedor_V.setEstado(Integer.parseInt(request.getParameter("select_v")));
                    }
                    ListarProv objProv = new ListarProv();
                    objProv.ModificarP_V(objProveedor_V);
                    request.setAttribute("msg", "Se Modifico Correctamente");
                    if ((request.getParameter("type").equals("prov"))) {
                        HttpSession Session = request.getSession(false);
                        Session.removeAttribute("usuario");
                        Session.invalidate();
                        request.getRequestDispatcher("/login_prov.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                    }

                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    if ((request.getParameter("type").equals("prov"))) {
                        request.getRequestDispatcher("/dashboard_prov_v.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                    }
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 7: {
                //Consulta Prov E           
                try {

                    response.setContentType("application/json");
                    String ruc = request.getParameter("ruc");
                    ListarProv objProv_E = new ListarProv();
                    objProv_E.BuscarProv_E(ruc);
                    JSONObject objJSONObject = new JSONObject();
                    PrintWriter out = response.getWriter();
                    objJSONObject.put("ruc", objProv_E.BuscarProv_E(ruc).getRuc());
                    objJSONObject.put("razon", objProv_E.BuscarProv_E(ruc).getRazon());
                    objJSONObject.put("direccion", objProv_E.BuscarProv_E(ruc).getDireccion());
                    objJSONObject.put("email", objProv_E.BuscarProv_E(ruc).getEmail());
                    objJSONObject.put("cont", objProv_E.BuscarProv_E(ruc).getContacto());
                    objJSONObject.put("ncont", objProv_E.BuscarProv_E(ruc).getNContacto());
                    objJSONObject.put("lon", objProv_E.BuscarProv_E(ruc).getLong());
                    objJSONObject.put("lat", objProv_E.BuscarProv_E(ruc).getLati());
                    objJSONObject.put("est", objProv_E.BuscarProv_E(ruc).getEstado());
                    objJSONObject.put("hini", objProv_E.BuscarProv_E(ruc).getHini());
                    objJSONObject.put("hfin", objProv_E.BuscarProv_E(ruc).getHfin());
                    out.print(objJSONObject);
                    out.close();
                } catch (Exception ex) {
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 8: {
                //Modificar Prov E     
                try {
                    Proveedor_E objProveedor_E = new Proveedor_E();
                    objProveedor_E.setRuc(Long.parseLong(request.getParameter("ruc_e")));
                    objProveedor_E.setRazon(new String(request.getParameter("razon_e").getBytes("ISO-8859-1"), "UTF-8"));
                    objProveedor_E.setDireccion(new String(request.getParameter("direc_e").getBytes("ISO-8859-1"), "UTF-8"));
                    objProveedor_E.setEmail(request.getParameter("email_e"));
                    objProveedor_E.setContacto(request.getParameter("cont_e"));
                    objProveedor_E.setNContacto(Integer.parseInt(request.getParameter("ncont_e")));
                    objProveedor_E.setLong(request.getParameter("long_e"));
                    objProveedor_E.setLati(request.getParameter("lat_e"));
                    objProveedor_E.setHini(request.getParameter("hini_e"));
                    objProveedor_E.setHfin(request.getParameter("hfin_e"));
                    if ((request.getParameter("type").equals("prov"))) {
                        objProveedor_E.setEstado(1);
                    } else {
                        objProveedor_E.setEstado(Integer.parseInt(request.getParameter("select_e")));
                    }
                    ListarProv objProv = new ListarProv();
                    objProv.ModificarP_E(objProveedor_E);
                    request.setAttribute("msg", "Se Modifico Correctamente");
                    if ((request.getParameter("type").equals("prov"))) {
                        HttpSession Session = request.getSession(false);
                        Session.removeAttribute("usuario");
                        Session.invalidate();
                        request.getRequestDispatcher("/login_prov.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                    }

                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    if ((request.getParameter("type").equals("prov"))) {
                        request.getRequestDispatcher("/dashboard_prov_e.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                    }
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;
            }
            case 9: {
                //Consulta Usuario         
                try {

                    response.setContentType("application/json");
                    String dni = (String) request.getParameter("dni");
                    ListarUsuarios objUsu = new ListarUsuarios();
                    objUsu.BuscarUsu(dni);
                    JSONObject objJSONObject = new JSONObject();
                    PrintWriter out = response.getWriter();
                    objJSONObject.put("dni", objUsu.BuscarUsu(dni).getDNI());
                    objJSONObject.put("nom", objUsu.BuscarUsu(dni).getNombres());
                    objJSONObject.put("app", objUsu.BuscarUsu(dni).getApelPaterno());
                    objJSONObject.put("apm", objUsu.BuscarUsu(dni).getApelMaterno());
                    objJSONObject.put("email", objUsu.BuscarUsu(dni).getEmail());
                    objJSONObject.put("est", objUsu.BuscarUsu(dni).getEstado());
                    objJSONObject.put("cel", objUsu.BuscarUsu(dni).getCel());
                    out.print(objJSONObject);
                    out.close();
                } catch (Exception ex) {
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 10: {
                //Modificar Usuario     
                try {
                    Usuarios objusu = new Usuarios();
                    objusu.setDNI(Long.parseLong(request.getParameter("dni_u")));
                    objusu.setNombres(request.getParameter("nom_u"));
                    objusu.setApelPaterno(request.getParameter("app_u"));
                    objusu.setApelMaterno(request.getParameter("apm_u"));
                    objusu.setEmail(request.getParameter("email_u"));
                    objusu.setCel(Integer.parseInt(request.getParameter("cel_u")));
                    objusu.setEstado(Integer.parseInt(request.getParameter("select_u")));
                    ListarUsuarios objLista = new ListarUsuarios();
                    objLista.ModificarU(objusu);
                    request.setAttribute("msg", "Se Modifico Correctamente");
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;
            }
            case 11: {
                //Eliminar Usuario
                try {
                    String dni = request.getParameter("idni_u");
                    ListarUsuarios objusu = new ListarUsuarios();
                    objusu.EliminarU(dni);
                    request.setAttribute("msg", "Accion Completada");
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;
            }
            case 12: {
                //Consulta Articulo    
                try {
                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    JSONObject objJSONObject = new JSONObject();
                    String cod = request.getParameter("cod");
                    ListarArticulos lista = new ListarArticulos();
                    objJSONObject.put("cod", lista.BuscarArticulo(cod).getCod());
                    objJSONObject.put("nom", lista.BuscarArticulo(cod).getNom());
                    objJSONObject.put("precio", lista.BuscarArticulo(cod).getPrecio());
                    objJSONObject.put("cant", lista.BuscarArticulo(cod).getCant());
                    objJSONObject.put("cate", lista.BuscarArticulo(cod).getCat());
                    objJSONObject.put("descrip", lista.BuscarArticulo(cod).getDescrip());
                    objJSONObject.put("estado", lista.BuscarArticulo(cod).getArti_estado());
                    objJSONObject.put("ruta", lista.BuscarArticulo(cod).getRutaimg());
                    out.print(objJSONObject);
                    out.close();
                } catch (Exception ex) {
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;
            }
            case 13: {
                //Consulta Categoria    
                try {
                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    JSONObject objJSONObject = new JSONObject();
                    ListarArticulos lista = new ListarArticulos();
                    objJSONObject.put("cate", lista.Lista_Categorias());
                    out.print(objJSONObject);
                    out.close();
                } catch (Exception ex) {
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;
            }
            case 14: {
                //Transaladado a ServletImagen op=2
                break;
            }
            case 15: {
                //Eliminar Articulo Prov
                try {
                    String cod = request.getParameter("codarti");
                    ListarArticulos objLista = new ListarArticulos();
                    objLista.Eliminar(cod);
                    request.setAttribute("msg", "Accion Completada");
                    request.getRequestDispatcher("/dashboard_prov_v.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_prov_v.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;
            }
            case 16: {
                //Ingresar Articulo     
                //Tranasladado ServletImagen
            }
            case 17: {
                //Datos Mapa    
                try {
                    Envios objEnvios = new Envios();
                    ListarProv objProv = new ListarProv();
                    ListarEnvios objListEnvio = new ListarEnvios();
                    objEnvios.setCarti(request.getParameter("Carti"));
                    objEnvios.setCventa(request.getParameter("Cventa"));
                    request.setAttribute("lat_en", objListEnvio.BuscarEnvio(objEnvios).getLat());
                    request.setAttribute("long_en", objListEnvio.BuscarEnvio(objEnvios).getLon());
                    request.setAttribute("lat_pv", objProv.BuscarProv_V(String.valueOf(objListEnvio.BuscarEnvio(objEnvios).getPv_ruc())).getLati());
                    request.setAttribute("long_pv", objProv.BuscarProv_V(String.valueOf(objListEnvio.BuscarEnvio(objEnvios).getPv_ruc())).getLong());
                    request.getRequestDispatcher("/ruta_maps.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/ruta_maps.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;
            }
            case 18: {
                //Tomar Entrega    
                try {
                    ListarEnvios objListarEnvios = new ListarEnvios();
                    String codvent = request.getParameter("codvent");
                    String codarti = request.getParameter("codarti_en");
                    HttpSession Session = request.getSession(false);
                    Proveedor_E objProv = (Proveedor_E) Session.getAttribute("usuario");
                    objListarEnvios.Tomar_Entrega(codvent, codarti, objProv.getRuc());
                    request.setAttribute("msg", "A tomado una entrega, Click en 'Mis Envios' para mas informacion");
                    request.getRequestDispatcher("/dashboard_prov_e.jsp").forward(request, response);

                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_prov_e.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 19: {
                //Completar Entrega    
                try {
                    ListarEnvios objListarEnvios = new ListarEnvios();
                    String venta = request.getParameter("id_v");
                    String arti = request.getParameter("id_art");
                    objListarEnvios.Completar_Envio(venta, arti);
                    request.setAttribute("msg", "¡Envio Completado!");
                    request.getRequestDispatcher("/dashboard_prov_e.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_prov_e.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 20: {
                //Deshabilitar Venta
                try {
                    ListarVentas Ventas = new ListarVentas();
                    String codv = request.getParameter("codv");
                    Ventas.DeshabilitarVenta(codv);
                    request.setAttribute("msg", "Accion Completada");
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 21: {
                //Buscar Venta
                try {
                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    JSONObject objJSONObject = new JSONObject();
                    ListarVentas Ventas = new ListarVentas();
                    String codv = request.getParameter("codv");
                    objJSONObject.put("cod_v", Ventas.BuscarVenta(codv).getCodv());
                    objJSONObject.put("fecha", Ventas.BuscarVenta(codv).getFechav());
                    objJSONObject.put("dni", Ventas.BuscarVenta(codv).getDNI());
                    objJSONObject.put("ndni", Ventas.BuscarVenta(codv).getNDNI());
                    objJSONObject.put("latv", Ventas.BuscarVenta(codv).getLatV());
                    objJSONObject.put("longv", Ventas.BuscarVenta(codv).getLongV());
                    objJSONObject.put("totalv", Ventas.BuscarVenta(codv).getTotalV());
                    objJSONObject.put("estadov", Ventas.BuscarVenta(codv).getEstadoV());
                    out.print(objJSONObject);
                    out.close();
                } catch (Exception ex) {
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 22: {
                //Actualizar Venta
                try {
                    ListarVentas objListaV = new ListarVentas();
                    String cod_v = request.getParameter("cod_v");
                    String dni_v = request.getParameter("dni_v");
                    String fecha_v = request.getParameter("fecha_v");
                    String total_v = request.getParameter("total_v");
                    String estado_v = request.getParameter("estado_v");
                    String long_venta = request.getParameter("long_venta");
                    String lati_venta = request.getParameter("lati_venta");
                    objListaV.ActualizarVentas(cod_v, dni_v, total_v, lati_venta, long_venta, estado_v, fecha_v);
                    request.setAttribute("msg", "Se Modifico Correctamente");
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 23: {
                //Listar Detalle_Venta
                try {
                    response.setContentType("text/html");
                    PrintWriter out = response.getWriter();
                    ListarVentas objListaV = new ListarVentas();
                    String cod_v = request.getParameter("codv");
                    List<CarritoCompras> objListaCarrito = objListaV.BuscarDetalle(cod_v);
                    String x;
                    x = "<table class='table table-responsive-sm table-bordered'>";
                    x = x + "<thead class='thead-dark'>";
                    x = x + "<th>Cod. Articulo</th>";
                    x = x + "<th>Articulo</th>";
                    x = x + "<th>Precio</th>";
                    x = x + "<th>Cantidad</th>";
                    x = x + "</thead>";
                    for (int i = 0; i < objListaCarrito.size(); i++) {
                        x = x + "<tr><td>" + objListaCarrito.get(i).getCod() + "</td>";
                        x = x + "<td>" + objListaCarrito.get(i).getNom() + "</td>";
                        x = x + "<td>" + objListaCarrito.get(i).getPrec() + "</td>";
                        x = x + "<td>" + objListaCarrito.get(i).getCant() + "</td></tr>";
                    }
                    x = x + "</table>";
                    x = x + "<input type='hidden' value='" + cod_v + "'/>";
                    out.print(x);
                } catch (Exception ex) {
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 24: {
                //Eliminar Articulo Admin
                try {
                    String codarti = request.getParameter("codarti");
                    ListarArticulos objLista = new ListarArticulos();
                    objLista.Eliminar(codarti);
                    request.setAttribute("msg", "Accion Completada");
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }

            case 25: {
                //Cambiar contraseña Prov
                try {
                    HttpSession Session = request.getSession();
                    String ruc = "";
                    if ((request.getParameter("type").equals("prov_e"))) {
                        Proveedor_E objProv = (Proveedor_E) Session.getAttribute("usuario");
                        ruc = String.valueOf(objProv.getRuc());
                    } else {
                        Proveedor_V objProv = (Proveedor_V) Session.getAttribute("usuario");
                        ruc = String.valueOf(objProv.getRuc());
                    }
                    String newpass = request.getParameter("newpass");
                    String oldpass = request.getParameter("oldpass");
                    ListarProv objLista = new ListarProv();
                    if (objLista.CambiarPass(oldpass, newpass, ruc)) {
                        Session.removeAttribute("usuario");
                        Session.invalidate();
                        request.setAttribute("msg", "Cambios Realizado Correctamente");
                        request.getRequestDispatcher("/login_prov.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "La Contraseña antigua ingresada no es correcta");
                        if ((request.getParameter("type").equals("prov_e"))) {
                            request.getRequestDispatcher("/dashboard_prov_e.jsp").forward(request, response);
                        } else {
                            request.getRequestDispatcher("/dashboard_prov_v.jsp").forward(request, response);
                        }

                    }
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    if ((request.getParameter("type").equals("prov_e"))) {
                        request.getRequestDispatcher("/dashboard_prov_e.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("/dashboard_prov_v.jsp").forward(request, response);
                    }
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;

            }
            case 26: {
                //Filtrar Ventas Prov V
                try {
                    HttpSession Session = request.getSession();
                    Proveedor_V objProv = (Proveedor_V) Session.getAttribute("usuario");
                    String filter[] = request.getParameter("filter_sell").split("/");
                    ListarVentas objListaV = new ListarVentas();
                    List<CarritoCompras> objCarr = objListaV.BuscarDetaVentasProv(objProv.getRuc(), filter[0], filter[1]);
                    request.setAttribute("filter_sell", objCarr);
                    request.getRequestDispatcher("/dashboard_prov_v.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_prov_v.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }

            case 27: {
                //Filtrar Articulos Prov V
                try {
                    HttpSession Session = request.getSession();
                    Proveedor_V objProv = (Proveedor_V) Session.getAttribute("usuario");
                    String cod_arti = request.getParameter("search_arti");
                    ListarArticulos objListaA = new ListarArticulos();
                    ArrayList<Articulos> objlist = objListaA.BuscarArticulos(objProv.getRuc(), cod_arti);
                    request.setAttribute("filter_arti", objlist);
                    request.getRequestDispatcher("/dashboard_prov_v.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_prov_v.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }

            case 28: {
                //Filtrar Prov V
                try {
                    String ruc = request.getParameter("search_PV");
                    ListarProv objListaP = new ListarProv();
                    ArrayList<Proveedor_V> objlistPV = objListaP.ListarProveedor_V(ruc);
                    request.setAttribute("filter_PV", objlistPV);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 29: {
                //Filtrar Prov V
                try {
                    String ruc = request.getParameter("search_PE");
                    ListarProv objListaP = new ListarProv();
                    ArrayList<Proveedor_E> objlistPE = objListaP.ListarProveedor_E(ruc);
                    request.setAttribute("filter_PE", objlistPE);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 30: {
                //Filtrar Usuario
                try {
                    String dni = request.getParameter("search_U");
                    ListarUsuarios objListaU = new ListarUsuarios();
                    ArrayList<Usuarios> objlistU = objListaU.ListarUsuarios(dni);
                    request.setAttribute("filter_U", objlistU);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }

            case 31: {
                //Filtrar Articulos
                try {
                    String cod_arti = request.getParameter("search_arti");
                    ListarArticulos objListaA = new ListarArticulos();
                    List<Articulos> objlistA = objListaA.ListarArticulosAdmin(cod_arti);
                    request.setAttribute("filter_A", objlistA);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 32: {
                //Filtrar Ventas
                try {
                    String cod_v = request.getParameter("search_v");
                    ListarVentas objListaV = new ListarVentas();
                    List<Ventas> objlistV = objListaV.ListarVentas(cod_v);
                    request.setAttribute("filter_V", objlistV);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_admin.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 33: {
                //Reporte
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                JSONObject objJSONObject = new JSONObject();
                HttpSession Session = request.getSession();
                ListarVentas objListv = new ListarVentas();
                Proveedor_V objprov = (Proveedor_V) Session.getAttribute("usuario");
                String[] time = request.getParameter("time").split("/");
                String mes = time[0];
                String año = time[1];
                try {              
                    objJSONObject.put("data",objListv.ReporteVentas(objprov.getRuc(), mes, año));
                    out.print(objJSONObject);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/dashboard_prov_v.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
