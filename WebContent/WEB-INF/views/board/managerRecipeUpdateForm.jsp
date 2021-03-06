<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="board.model.vo.*, java.util.*, product.model.vo.*"%>
    
<%
	ManagerRecipe managerRecipe = (ManagerRecipe)request.getAttribute("managerRecipe");
	ArrayList<MRAttachment> fileList = (ArrayList<MRAttachment>)request.getAttribute("fileList");
	MRAttachment titleImg = fileList.get(0);
	
	ArrayList<Product> product = (ArrayList<Product>)request.getAttribute("product");
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레팩 레시피 수정 - <%= managerRecipe.getM_R_Title() %></title>
<style>
.write{
      width: 80%; border: 5px solid white;
      margin-left: auto; margin-right: auto;
    }
table {
	  border-collapse: separate;
	  border-spacing: 0 8px;
	}
th{border-bottom: 1px solid white; background: #589284; color:white; height:30px;}
.buttonArea{margin-right: 50px; margin-botton: 30px;}
.buttonArea button{background: #D1B2FF; border-radius: 5px; color: white; width: 80px; heigth: 25px; text-align: center;}
button:hover{cursor: pointer;}
#insertBtn, #cancelBtn{background: #589284; border-radius: 50px; color: white; width: 80px; height: 25px; display: inline-block; margin-bottom: 20px;}
#insertBtn:hover, #cancelBtn:hover{cursor: pointer;}
#cancelBtn{background: gray;}	
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	
	<div class="write" align="center">
		<br><br><br><br>
		<h2 align="center">레펙 레시피 만들기 보글보글</h2>
		
		
		<form action="<%= request.getContextPath() %>/updateManagerRecipe.th" method="post" encType="multipart/form-data">
			<div class="insertArea">
			<br><br>
				<table id="insertManagerRecipe">
					<br><br>
						<th width="200px">레시피 제목
						<input type="hidden" name="bId" value="<%= managerRecipe.getM_R_NO() %>">
						<input type="hidden" id="pId" name="pId" value="<%= managerRecipe.getP_Id() %>">
						</th>
						<td colspan="3"><input type="text" size="45" name="title" value="<%= managerRecipe.getM_R_Title() %>"></td>
					</tr>
					<tr>
						<th width="200px"><span>레시피 재료</span></th>
							<% if(product.isEmpty()) { %>
						    	<td>조회된 재료가 없습니다.</td>
						    <% } else { %>
						    <td width="100px">
						    	<% for(Product p : product) { %>
						    		<input type="checkbox" id="food" name="food" value=<%= p.getpId() %>>
									<label><%= p.getpName() %></label>
									
						    	<% } %></td>
						    <% } %>
						
					</tr>
					<tr>
						<th><span>레시피 썸네일<br>(이미지 첨부)</span></th>
						<td>
							<div id="fileArea">
								<input type="file" id="thumbnailImg1" multiple="multiple" name="thumbnailImg1" onchange="LoadImg(this,1)">
							</div>
						</td>
					</tr>
					<tr>
						<th><span>레시피 설명<br>(이미지 첨부)</span></th>
						<td>
							<div id="fileArea">
								<input type="file" id="thumbnailImg2" multiple="multiple" name="thumbnailImg2" onchange="LoadImg(this,2)">
							</div>
						</td>
					</tr>
					<tr>
						<th><span>레시피 용량</span></th>
						<td><input type="text" size="10" name="cap" value="<%= managerRecipe.getM_R_Capacity() %>"></td>
					</tr>
					<tr>
						<th><span>레시피 가격</span></th>
						<td><input type="text" size="10" name="price" value="<%= managerRecipe.getM_R_price() %>">원</td>
					</tr>
					<tr>
						<th><span>레시피 원산지</span></th>
						<td><input type="text" size="10" name="origin" value="<%= managerRecipe.getM_R_Origin() %>"></td>
					</tr>
					<tr>
						<th><span>썸네일 미리보기</span></th>
						<td colspan="3">
							<div id="titleImgArea">
								<img id="titleImg" width="120" height="100" src="<%= request.getContextPath() %>/thumbnail_uploadFiles/<%= titleImg.getChangeName() %>">
							</div>
								<input type="hidden" name="fId" value="<%= titleImg.getFileId()%>">
								<input type="hidden" name="oldFileName" value="<%= titleImg.getChangeName() %>">
							
						</td>
					</tr>
					<tr>
						<th>미리보기</th>
						<td colspan="3">
							<div id="contentImgArea1">
								<img id="contentImg1" width="350" height="200" src="<%= request.getContextPath() %>/thumbnail_uploadFiles/<%= fileList.get(1).getChangeName() %>"> 
							</div>
								<input type="hidden" name="fId" value="<%= fileList.get(1).getFileId() %>">
								<input type="hidden" name="oldFileName" value="<%= fileList.get(1).getChangeName() %>">
						</td>
					</tr>
				</table>
								
				<script>
				function LoadImg(value, num){
						if(value.files && value.files[0]){
							var reader = new FileReader();
							
							reader.onload = function(e){								
								switch(num){
								case 1: 
									$("#titleImg").attr("src", e.target.result);
									break;
								case 2:
									$("#contentImg1").attr("src", e.target.result);
									break;
								
								}
							}
							
							reader.readAsDataURL(value.files[0]);
						}
					}
				
				function LoadProduct(value){
					System.out.println("value"+value);
				}
				
				</script>
				
				
				
			</div>
			
			<br><br><br>
			
			<div class="btnArea">
				<input type="submit" id="insertBtn" value="작성완료">
				<input type="button" id="cancelBtn" onclick="location.href='<%= request.getContextPath() %>/list.managerR'" value="취소하기">
			</div>
			<br><br><br>
			
		</form>
	</div>
	
	<%@ include file="../common/footer.jsp" %>
</body>
</html>