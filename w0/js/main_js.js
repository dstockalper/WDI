$(document).ready(function(){

	var position = 0;
	var slideOffset = 0;
		
	setInterval(function(){
		position +=1;
		slideOffset+=-150;
		if(position%4==0){
			$("#slideReel").animate({left: 0});
			slideOffset=0;
			position=0;
		}else{
			$("#slideReel").animate({left: slideOffset});
		}
	}, 10000);

	$("#desc").on("click", function(){
		$(this).toggleClass("sideLeft");
		$(this).toggleClass("sideRight");
		$("#meImage").toggleClass("sideRight");
		$("#meImage").toggleClass("sideLeft");
	})

	$("#meImage").on("click", function(){
		$(this).toggleClass("sideLeft");
		$(this).toggleClass("sideRight");
		$("#desc").toggleClass("sideRight");
		$("#desc").toggleClass("sideLeft");
	})
	
});