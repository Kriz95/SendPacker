package Controlador;

import DAO.CarritoyVentas;
import DAO.ListarUsuarios;
import DAO.ListarVentas;
import DAO.ValLoginImp;
import Modelo.CarritoCompras;
import Modelo.Usuarios;
import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ServletCliente", urlPatterns = {"/ServletCliente"})
public class ServletCliente extends HttpServlet {

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
                //Iniciar Session
                String dnicliente = request.getParameter("txtdnicliente");
                String contraseñacliente = request.getParameter("txtclavecliente");
                ValLoginImp objVal = new ValLoginImp();
                try {
                    if (objVal.ValLoginUser(dnicliente, contraseñacliente)) {
                        HttpSession Session = request.getSession();
                        ListarUsuarios objListarU = new ListarUsuarios();
                        Session.setAttribute("DatosUser", objListarU.BuscarUsu(dnicliente));
                        request.getRequestDispatcher("tienda.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Datos Ingresados Incorrectos");
                        request.getRequestDispatcher("login_user.jsp").forward(request, response);
                    }
                } catch (Exception ex) {
                    Logger.getLogger(ServletCliente.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 2: {
                //Registrar Cliente
                Usuarios objUser = new Usuarios();
                objUser.setDNI(Long.parseLong(request.getParameter("txtdniclientereg")));
                objUser.setApelPaterno(request.getParameter("txtapellidopatcliente"));
                objUser.setApelMaterno(request.getParameter("txtapellidomatcliente"));
                objUser.setNombres(request.getParameter("txtnombrecliente"));
                objUser.setEmail(request.getParameter("txtemailcliente"));
                objUser.setPass(request.getParameter("txtclaveclientereg"));
                objUser.setCel(Integer.parseInt(request.getParameter("celcliente")));
                ListarUsuarios objListaU = new ListarUsuarios();
                try {
                    objListaU.RegistrarU(objUser);
                    request.setAttribute("msg", "Registrado Correctamente");
                    request.getRequestDispatcher("login_user.jsp").forward(request, response);
                } catch (SQLIntegrityConstraintViolationException ex1) {
                    request.setAttribute("error", "El usuario ya se encuentra registrado");
                    request.getRequestDispatcher("login_user.jsp").forward(request, response);
                    Logger.getLogger(ServletCliente.class.getName()).log(Level.SEVERE, null, ex1);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("login_user.jsp").forward(request, response);
                    Logger.getLogger(ServletCliente.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 3: {
                //Cerrar Session
                HttpSession Session = request.getSession();
                Session.removeAttribute("DatosUser");
                Session.removeAttribute("CarritoUser");
                Session.invalidate();
                request.getRequestDispatcher("index.jsp").forward(request, response);
                break;
            }
            case 4: {
                //Crear Carrito y Agregar
                HttpSession Session = request.getSession(false);
                CarritoyVentas objCarrito = new CarritoyVentas();
                String cant = request.getParameter("articant");
                String codarti = request.getParameter("codarti");
                if (Session.getAttribute("CarritoUser") == null) {
                    List<CarritoCompras> objListaCar = new ArrayList();
                    try {
                        objListaCar.add(objCarrito.BuscarArticulo(codarti, cant));
                        request.setAttribute("msg", "¡Articulo Agregado al Carrito!");
                        Session.setAttribute("CarritoUser", objListaCar);
                    } catch (Exception ex) {
                        Logger.getLogger(ServletCliente.class.getName()).log(Level.SEVERE, null, ex);
                    }
                } else {
                    try {
                        boolean flag = false;
                        List<CarritoCompras> objListaCar = (List<CarritoCompras>) Session.getAttribute("CarritoUser");
                        for (int i = 0; i < objListaCar.size(); i++) {
                            if (objListaCar.get(i).getCod().equals(codarti)) {
                                objListaCar.get(i).setCant(objListaCar.get(i).getCant() + Integer.parseInt(cant));
                                objListaCar.get(i).setTotal(objListaCar.get(i).getCant() * objListaCar.get(i).getPrec());
                                flag = true;
                                break;
                            }
                        }
                        if (flag != true) {
                            objListaCar.add(objCarrito.BuscarArticulo(codarti, cant));
                        }
                        request.setAttribute("msg", "¡Articulo Agregado al Carrito!");
                        Session.setAttribute("CarritoUser", objListaCar);
                    } catch (Exception ex) {
                        request.setAttribute("error", ex);
                        Logger.getLogger(ServletCliente.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                request.getRequestDispatcher("tienda.jsp").forward(request, response);
                break;
            }
            case 5: {
                //Aceptar Compra
                HttpSession Session = request.getSession(false);
                CarritoyVentas objCarrito = new CarritoyVentas();
                String totalcompra = request.getParameter("totalcompra");
                String lati = request.getParameter("lat");
                String longi = request.getParameter("long");
                try {
                    objCarrito.Ingresar_Venta((List<CarritoCompras>) Session.getAttribute("CarritoUser"), (Usuarios) Session.getAttribute("DatosUser"), lati, longi, totalcompra);
                    Session.removeAttribute("CarritoUser");
                    request.setAttribute("msg", "¡Compra Realizada! Para ver detalles de las compras hacer click <a href='AccountUserSell.jsp' class='alert-link'>aqui</a>");
                    request.getRequestDispatcher("tienda.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/CompraConf.jsp").forward(request, response);
                    Logger.getLogger(ServletCliente.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 6: {
                //Modificar Usuario     
                try {
                    HttpSession Session = request.getSession();
                    Usuarios objDatosusu = (Usuarios) Session.getAttribute("DatosUser");
                    Usuarios objusu = new Usuarios();
                    objusu.setDNI(objDatosusu.getDNI());
                    objusu.setNombres(request.getParameter("txtnombre"));
                    objusu.setApelPaterno(request.getParameter("txtapp"));
                    objusu.setApelMaterno(request.getParameter("txtapm"));
                    objusu.setEmail(request.getParameter("txtcorreo"));
                    objusu.setCel(Integer.parseInt(request.getParameter("txtcel")));
                    objusu.setEstado(1);
                    ListarUsuarios objLista = new ListarUsuarios();
                    objLista.ModificarU(objusu);
                    Session.removeAttribute("DatosUser");
                    Session.removeAttribute("CarritoUser");
                    Session.invalidate();
                    request.setAttribute("msg", "Modificado Correctamente");
                    request.getRequestDispatcher("/login_user.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/AccountUserEdit.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 7: {
                //Cambiar Contraseña     
                try {
                    HttpSession Session = request.getSession();
                    Usuarios objUsuarios = (Usuarios) Session.getAttribute("DatosUser");
                    String dni = String.valueOf(objUsuarios.getDNI());
                    String newpass = request.getParameter("newpass");
                    String oldpass = request.getParameter("oldpass");
                    ListarUsuarios objLista = new ListarUsuarios();
                    if (objLista.CambiarPass(oldpass, newpass, dni)) {
                        Session.removeAttribute("DatosUser");
                        Session.removeAttribute("CarritoUser");
                        Session.invalidate();
                        request.setAttribute("msg", "Cambios Realizado Correctamente");
                        request.getRequestDispatcher("/login_user.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "La Contraseña antigua ingresada no es correcta");
                        request.getRequestDispatcher("/AccountUserEdit.jsp").forward(request, response);
                    }
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/AccountUserEdit.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 8: {
                //Eliminar Articulo de Carrito     
                try {
                    HttpSession Session = request.getSession(false);
                    String codarti = request.getParameter("codarti");
                    List<CarritoCompras> objlistaCarr = (List<CarritoCompras>) Session.getAttribute("CarritoUser");
                    for (int i = 0; i < objlistaCarr.size(); i++) {
                        if (objlistaCarr.get(i).getCod().equals(codarti)) {
                            objlistaCarr.remove(i);
                            break;
                        }
                    }
                    request.setAttribute("msg", "Articulo Eliminado Correctamente");
                    request.getRequestDispatcher("/CompraConf.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/CompraConf.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 9: {
                //Modificar Cantidad Articulo de Carrito     
                try {
                    HttpSession Session = request.getSession(false);
                    String codarti = request.getParameter("codart_cant");
                    String cant = request.getParameter("cantarti");
                    List<CarritoCompras> objlistaCarr = (List<CarritoCompras>) Session.getAttribute("CarritoUser");
                    for (int i = 0; i < objlistaCarr.size(); i++) {
                        if (objlistaCarr.get(i).getCod().equals(codarti)) {
                            objlistaCarr.get(i).setCant(Integer.parseInt(cant));
                            objlistaCarr.get(i).setTotal(objlistaCarr.get(i).getCant() * objlistaCarr.get(i).getPrec());
                            break;
                        }
                    }
                    Session.setAttribute("CarritoUser", objlistaCarr);
                    request.setAttribute("msg", "Articulo Modificado Correctamente");
                    request.getRequestDispatcher("/CompraConf.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/CompraConf.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case 10: {
                //Sugerencias   
                request.setAttribute("msg", "Mensaje Enviado");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                break;
            }
            case 11: {
                //Filtrar Compras     
                try {
                    HttpSession Session = request.getSession(false);
                    String filter[] = request.getParameter("filter_month").split("/");
                    Usuarios objUsuarios = (Usuarios) Session.getAttribute("DatosUser");
                    List<CarritoCompras> objlistaCarr = null;
                    ListarVentas objListaV = new ListarVentas();
                    objlistaCarr = objListaV.FiltrarComprasUser(String.valueOf(objUsuarios.getDNI()), filter[0], filter[1]);
                    request.setAttribute("filter_buy", objlistaCarr);
                    request.getRequestDispatcher("/AccountUserSell.jsp").forward(request, response);
                } catch (Exception ex) {
                    request.setAttribute("error", ex);
                    request.getRequestDispatcher("/AccountUserSell.jsp").forward(request, response);
                    Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
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
