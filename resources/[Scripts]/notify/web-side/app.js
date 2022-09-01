$(document).ready(function(){
	let blocked = false
	let list = []
	var audioPlayer = null;

	window.addEventListener("message",function(event){
		switch(event.data.type){
			case "notify":
				var html = "<div id='"+event.data.css+"'>"+event["data"]["mensagem"]+"</div>"
				$(html).fadeIn(500).appendTo("#notifications").delay(event["data"]["timer"]).fadeOut(500);
			break;

			case "notifyItem":
				var html = `
					<div class="item" id="${event.data.mode}">
						<div class="item-mode">${event.data.mode}</div>
						<img src="http://yeahrp.com/items/${event.data.item}.png">
						<div class="info-item">
							<div class="nameItem">${event.data.name}</div>
							<div class="itemRecive">${event.data.mode === 'recebeu' ? `+${event.data.amount}` : `-${event.data.amount}`}</div>
						</div>
					</div>
				`;

				$(html).fadeIn(500).appendTo("#notifyitens").delay(3000).fadeOut(500);
			break;
			
			case "notifyCall":
				switch(event.data.action){
					case 'notify':
						addNotification(event.data.data)
					break

					case 'showAll':
						if (list.length > 0){
							showLast()
							$.post("http://notify/focusOn")
						}
					break

					case 'hideAll':
						hideAll()
						$.post("http://notify/focusOff")
					break
				}
			break;

			case "hoverfy":
				if (event["data"]["show"] == true){
					var key = event["data"]["key"] !== undefined ? "<div id='key'>" + event["data"]["key"] + "</div>":""
		
					$("#displayNotify").html(key + "<div id='text'><b>" + event["data"]["title"] + "</b><br>" + event["data"]["legend"] + "</div>");
					$("#displayNotify").fadeIn(250);
				}
		
				if (event["data"]["show"] == false){
					$("#displayNotify").fadeOut(250);
				}
			break;

			case "sound":
				if (audioPlayer != null){ audioPlayer.pause(); }
				audioPlayer = new Audio("./sounds/"+event.data.transactionFile+".ogg");
				audioPlayer.volume = event.data.transactionVolume;
				audioPlayer.play();
			break;
		}

		if (event["data"]["tencode"] == true){
			$("#divCode").css("display","block");
		}

		if (event["data"]["tencode"] == false){
			$("#divCode").css("display","none");
		}

		if (event["data"]["radar"] == true){
			$("#divRadar").css("display","block");
		}

		if (event["data"]["radar"] == false){
			$("#divRadar").css("display","none");
		}

		if (event["data"]["radar"] == "top"){
			$("#topRadar").html("<c>PLACA:</c> "+ event["data"]["plate"] +"     <c>MODELO:</c> "+ event["data"]["model"] +"     <c>VELOCIDADE:</c> "+ parseInt(event["data"]["speed"]) +" KMH");
		}

		if (event["data"]["radar"] == "bot"){
			$("#botRadar").html("<c>PLACA:</c> "+ event["data"]["plate"] +"     <c>MODELO:</c> "+ event["data"]["model"] +"     <c>VELOCIDADE:</c> "+ parseInt(event["data"]["speed"]) +" KMH");
		}
	})

	document.onkeyup = function(data){
		if (data.which == 27){
			hideAll()
			$.post("http://notify/focusOff")
		}
	};
	
	document.onkeyup = function(data){
		if (data["which"] == 27){
			$.post("http://notify/closeSystem");
		};
	};

	$(document).on("click","#loc",function(){
		$.post("http://notify/setWay",JSON.stringify({ x: $(this).attr("data-x"), y: $(this).attr("data-y") }))
	});

	$(document).on("click","#phone",function(){
		$.post("http://notify/phoneCall",JSON.stringify({ phone: $(this).attr("data-phone") }))
	});

	const hideAll = () => {
		blocked = false
		$(".body").css("overflow","hidden")
		$(".body").html("")
	};

	const addNotification = data => {
		if (list.length > 9) list.shift()

		const html = `${data.code === "QRT" ? `<div class="notification" style="background: #8e091c; border-left: 5px solid #580611;">` : `<div class="notification">`}
			<div class="content">
				${data.code === undefined ? "" : `<div class="code">${data.code}</div>`}

				<div class="titulo">${data.title}</div>

				${data.name === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data.name}</div>`}

				${data.street === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data.street}</div>`}

				${data.criminal === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data.criminal}</div>`}

				${data.vehicle === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data.vehicle}</div>`}

				${data.time === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data.time}</div>`}
			</div>

			<div class="buttons">
				<div class="chamados" id="loc" data-x="${data.x}" data-y="${data.y}"><i class="fas fa-map-marker-alt fa-lg"></i></div>
				${data.phone === undefined ? "" : `<div class="chamados" id="phone" data-phone="${data.phone}"><i class="fas fa-phone-alt"></i></div>`}
			</div>

			${data.text === undefined ? "" : `<div class="texto">${data.text}</div>`}
		</div>`

		list.push(html)

		if (!blocked){
			$(html).prependTo(".body")
			.hide()
			.show("slide",{ direction: "right" },250)
			.delay(5000)
			.hide("slide",{ direction: "right" },250)
		}
	};

	const showLast = () => {
		hideAll()
		blocked = true

		$(".body").css("overflow-y","scroll")
		for (i in list){
			$(list[i]).prependTo(".body")
		}
	};
});

/* ---------------------------------------------------------------------------------------------------------------- */
const clickCode = (data) => {
	$.post("http://notify/sendCode",JSON.stringify({ code: data }));
};