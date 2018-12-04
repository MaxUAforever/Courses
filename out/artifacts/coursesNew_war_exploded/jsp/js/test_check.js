function closePopUpConf(){
    var backPopUp = document.getElementById("popupconfcont");
    var popUp = document.getElementById("popupconf");
    backPopUp.style.display = "none";
    popUp.style.display = "none";
}

function openPopUpConf(){
    var backPopUp = document.getElementById("popupconfcont");
    var popUp = document.getElementById("popupconf");
    backPopUp.style.display = "inline";
    popUp.style.display = "inline";
}

function statusPressed(button){
  if (button == "confirm"){
    return true;
  }
  else{
    return false;
  }
}

function pageRedirect(ref){
    window.location.href = ref;
};