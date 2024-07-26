<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="verify" class="overlay">
    <div class="popup">
        <h2 class="ms-3 mb-3">H2DV Petshop</h2>
        <a class="close" href="#">&times;</a>
        <div class="content container-fluid">
            <h2>A verification link had been sended to ${sessionScope.mail}</h2>
            <h3>Check your email for verification!</h3>
        </div>
    </div>
</div>
