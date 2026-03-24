<%@ page contentType="text/html;charset=UTF-8" %>

<%
String status = (String) request.getAttribute("status");
String message = (String) request.getAttribute("message");
%>

<script>

<% if(message != null){ %>
alert("<%=message%>");
window.location = "orders";
<% } else if("success".equals(status)){ %>

alert("Payment Successful");
window.location = "dashboard.jsp";


<% } else { %>

alert("Payment Failed. If amount deducted, it will be refunded.");
window.location = "invoice.jsp";

<% } %>

</script>