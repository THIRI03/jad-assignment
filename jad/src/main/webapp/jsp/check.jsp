<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<% 
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("/jad/jsp/login.jsp");
        return;
    }
%>
