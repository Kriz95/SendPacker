<%-- 
    Document   : estadisticatodo
    Created on : 18/05/2018, 07:58:44 PM
    Author     : W10
--%>


<%@page import="modelo.total"%>
<%@page import="modelo.año"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="modelo.ingreso"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.lang.Object"%>
<%@page import="org.jfree.chart.*"%>
<%@page import="org.jfree.chart.plot.*"%>
<%@page import="org.jfree.data.general.*"%>
<%@page import="org.jfree.data.category.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table style="width:100%">
        <tr>
        <th bgcolor="green">
            <td bgcolor="green"><h1>GIFTSHOP</h1></td>
            <td bgcolor="green"></td>
            <td bgcolor="red" align="center"><a href="Index.jsp" style="text-decoration:none"><font size=6 color="white">Inicio</font></a></td>
            <td bgcolor="green" align="center"><a href="nosotros.jsp" style="text-decoration:none"><font size=6 color="white">Nosotros</font></a></td>
            <td bgcolor="green" align="center"><a href="año.jsp" style="text-decoration:none"><font size=6 color="white">Registrar</font></a></td>
            <td bgcolor="green" align="center"><a href="atencion.jsp" style="text-decoration:none"><font size=6 color="white">Atencion al cliente</font></a></td>
            <td bgcolor="green"></td>
        </th>
        </tr>
        </table>
        <table WIDTH="100%">
            <tr><td bgcolor="green"></td> </tr>
            <tr WIDTH="100%" weight="5000" ><td bgcolor="green"></td> </tr>
            <tr><td><br></tr></tr>
        <tr><td><br></tr></tr>
<td><center><font size=8>Cuadro estadistico</font></center></td>
<tr><td><br></tr></tr>
<tr><td><br></tr></tr>
<tr WIDTH="100%" weight="5000" ><td bgcolor="green"></td> </tr>
        <tr><td><br></tr></tr>
        <tr><td><br></tr></tr>
        </table>  
        <table WIDTH="100%" weight="5000">
        <tr bgcolor="green">
        <% 
 
            //Codigo de deteccion de calendario
 //Espacio- Inicio de Grafico
            //INSTANCIA QUE CORRESPONDE AL TIPO DE GRAFICO
            //CARGAREMOS LA DATA PARA LAS SERIES
            DefaultPieDataset data = new DefaultPieDataset();
            DefaultCategoryDataset datas = new DefaultCategoryDataset();
            
                 ArrayList<total> listaTotal = (ArrayList<total>)request.getAttribute("alistaTotal");
         
            
       //
        String ns="";
             int n=0;
             int ns1=0;
             int p=0;
             int inicio=0;
for (int i = 0; i < listaTotal.size(); i++) {
                n = Integer.parseInt(listaTotal.get(i).getTotal());
                ns = listaTotal.get(i).getYear();
                ns1 = Integer.parseInt(listaTotal.get(i).getYear());
                datas.setValue(n,"Ingreso",""+ns);
                if(i==0)    
                {
                    inicio=ns1;
                    p=listaTotal.size()-1;
                }
                
        }

            //GENERAR EL GRAFICO
            //JFreeChart grafico = ChartFactory.createPieChart("Ingresos obtenidos "+request.getAttribute("atiempo"), data, true, true, true);
            JFreeChart graficos = ChartFactory.createBarChart("Ingresos obtenidos ("+inicio+" - "+(inicio+p)+")", "AÑO", "PROMEDIO", datas,PlotOrientation.VERTICAL,true,true,true);

            
            //MEDIO DONDE SE VISUALIZARA EL GRADICO
            response.setContentType("image/JPEG");
            try{
                
            OutputStream sa = null;
            sa = response.getOutputStream();
            
            //IMPRESION DEL GRAFICO
            //ChartUtilities.writeChartAsJPEG(sa, grafico, 500, 500);
            ChartUtilities.writeChartAsJPEG(sa, graficos, 500, 500);
           
            //ChartUtilities.saveChartAsJPEG(new File("C:/xampp/htdocs/gift/web/graficatodo/graficas.jpeg"), grafico, 500, 500);
            sa.flush();
            sa.close();
             
            }catch(Exception e){
                
            }
            
            


%>
        <center><img src="graficatodo/graficas.jpeg"/></center>
        </tr>
        </table> 
    </body>
</html>
