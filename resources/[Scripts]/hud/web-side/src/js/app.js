const gears = ['R', 'N', '1', '2', '3', '4', '5', '6']
let timeoutFn = undefined;

function remove_voices_bars() {
  $('.micStatus').removeClass('active');
  let elements = document.querySelectorAll('.qTalk')

  for (let i in elements) {
    if (typeof elements[i] == 'object') {
      elements[i].classList.remove('active')
      elements[i].style.background = 'rgba(255, 255, 255, 0.4)'
    }
  }
}

function talking_voice() {
  let elements = document.querySelectorAll('.active')
  for (let i in elements) {
    if (typeof elements[i] == 'object') {
      elements[i].style.background = '#c4b408'
    }
  }
}

window.addEventListener('message', ({ data }) => {

  if (data.progressShow) {
    setCircle(0, 'circleFill')
    $(".progressBar").fadeIn();

    var start = new Date();
    let maxTime = data.progress;
    let timeoutVal = Math.floor(maxTime/100);
    animateUpdate();

    function updateProgress(percentage) {
      
      setCircle(percentage, 'circleFill')
      $('.progressBar .fill').css("width", percentage + "%");
    }

    function animateUpdate() {
      var now = new Date();
      var timeDiff = now.getTime() - start.getTime();
      var perc = Math.round((timeDiff/maxTime)*100);
      if (perc <= 100) {
        updateProgress(perc);
        setTimeout(animateUpdate, timeoutVal);
      } else {
        $(".progressBar").hide();
      }
    }
    
  }

  // ------------------------

  if (data.hud == true) {
    document.querySelector('body').style.display = 'flex'
  } else if (data.hud == false) {
    document.querySelector('body').style.display = 'none'
  }

  if (data.voice == '1') {
    remove_voices_bars()
    $('.micStatus:nth-child(1)').addClass('active');
    $('.micStatus:nth-child(1)').css('background', '#fff');
  } else if (data.voice == '2') {
    remove_voices_bars()
    $('.micStatus:nth-child(1)').addClass('active');
    $('.micStatus:nth-child(2)').addClass('active');
    $('.micStatus:nth-child(1)').css('background', '#fff');
    $('.micStatus:nth-child(2)').css('background', '#fff');
  } else if (data.voice == '3') {
    $('.micStatus:nth-child(1)').addClass('active');
    $('.micStatus:nth-child(2)').addClass('active');
    $('.micStatus:nth-child(3)').addClass('active');
    $('.micStatus:nth-child(1)').css('background', '#fff');
    $('.micStatus:nth-child(2)').css('background', '#fff');
    $('.micStatus:nth-child(3)').css('background', '#fff');
  } else {
    $('.micStatus:nth-child(n+1)').addClass('active');
    $('.micStatus').css('background', '#fff');
  }

  if (data.talking) talking_voice();

  if (data.health <= 1){
    setCircle("0", 'lifeFill')
  } else {
    setCircle(100 - data.health, 'lifeFill')
  }

 // setCircle(data.health, 'lifeFill')
  setCircle(data.armour, 'shieldFill')
  setCircle(data.stress, 'stressFill')
  setCircle(data.thirst, 'waterFill')
  setCircle(data.hunger, 'foodFill')

  let radio = document.querySelector('.radio')

  if (data.radio > 0 && data.radio != undefined) {
    $('.radio').fadeIn();
    radio.innerHTML = `
    <div class="icon">
      <i class="fa-solid fa-signal-stream"></i>
    </div>
    <span>${data.radio}.00 MHz</span>`
  } else {
    $('.radio').fadeOut();
    radio.innerHTML = ''
  }

  let hour = document.querySelector('.hour')
  hour.textContent = `${data.time}`

  let location = document.querySelector('.location')
  location.innerHTML = `${data.street} | ${data.direction}`

  if (data.vehicle) {
    $('.velocimeterHud').fadeIn('slow')
    let velo = document.querySelector('.velo');
    velo.textContent = data.speed

    if (Number(data.speed) <= 9) { velo.innerHTML = `00<b>${data.speed.toFixed(0)}</b>` }
    else if (Number(data.speed) <= 99) { velo.innerHTML = `0<b>${data.speed.toFixed(0)}</b>` }
    else { velo.innerHTML = `<b>${data.speed.toFixed(0)}</b>` }

    setProgressSpeed(data.speed, '.progress-speed');
    setProgressFuel(data.fuel.toFixed(0), '.progress-fuel');
    setCircle(data.vehicleEngine/10, 'engineFill')

    let gas_element = document.querySelector('.gasAmount')
    gas_element.innerHTML = `${data.fuel.toFixed(0)}<b>L</b>`
    let seatbelt = document.querySelector('.seatbelt')
    $('.lightCar').removeClass('activeLight');
    
    if (data.gear === 7) data.gear = 0
    
    let prevGear = gears[data.gear-1]
    let gear = gears[data.gear]
    let nextGear = gears[data.gear+1]
    
    $('.carMarch').html(`
      <small>${prevGear != null ? prevGear : ''}</small>
      <div>${gear}</div>
      <small>${nextGear != null ? nextGear : ''}</small>
    `)
    if ( data.lightState === 'up' ) $('.lightCar').addClass('activeLight');
    if ( data.lightState === 'left' ) $('#lightLeft').addClass('activeLight');
    if ( data.lightState === 'right' ) $('#lightRight').addClass('activeLight');
    if ( data.lightState === 'off' ) $('.lightCar').removeClass('activeLight');
    data.seatbelt == '1' ? seatbelt.classList.remove('activeBelt') : seatbelt.classList.add('activeBelt');
  } else {
    $('.velocimeterHud').fadeOut();
  }
});

function setProgressSpeed(value, element) {
  var circle = document.querySelector(element);
  var radius = circle.r.baseVal.value;
  var circumference = radius * 2 * Math.PI;
  var percent = value * 100 / 220;

  circle.style.strokeDasharray = `${circumference} ${circumference}`;
  circle.style.strokeDashoffset = `${circumference}`;
  const offset = circumference - ((-percent * 73) / 100) / 100 * circumference;
  circle.style.strokeDashoffset = -offset;
}

function setProgressFuel(percent, element){
  var circle = document.querySelector(element);
  var radius = circle.r.baseVal.value;

  var circumference = radius * 2 * Math.PI;
  var percent = percent * 100 / 178;

  circle.style.strokeDasharray = `${circumference} ${circumference}`;
  circle.style.strokeDashoffset = `${circumference}`;

  const offset = circumference - ((-percent*73)/100) / 100 * circumference;
  circle.style.strokeDashoffset = -offset;
}

function setCircle(percentage, fillClass) {
  let circle = document.querySelector(`.${fillClass}`)
  let calc = (113 * (100 - percentage)) / 100
  circle.style.strokeDashoffset = calc
}
