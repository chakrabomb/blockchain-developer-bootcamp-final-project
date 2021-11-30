console.log("breh")

window.addEventListener('load', function() {
    if(typeof window.ethereum !== 'undefined'){
        console.log("Metamask detected")
        let mmDetected = document.getElementById("mm-detected")
        mmDetected.innerHTML = "Metamask detected"
    }
    else{
        let mmDetected = document.getElementById("mm-detected")
        mmDetected.innerHTML = "Metamask not detected"
        alert("Log in to Metamask and connect to Ropsten, then refresh")

    }
})