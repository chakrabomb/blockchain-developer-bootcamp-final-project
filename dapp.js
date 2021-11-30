console.log("breh")

window.addEventListener('load', function() {
    if(typeof window.ethereum !== 'undefined'){
        console.log("Metamask detected")
        let mmDetected = document.getElementById("mm-detected")
        mmDetected.innerHTML = "Metamask detected"
        const mmConnect = document.getElementById("mm-connect")
        mmConnect.onclick = async () => {
            await ethereum.request({method: 'eth_requestAccounts'})
            if(window.ethereum.chainId == '0x3'){
                mmConnect.parentNode.removeChild(mmConnect)
                mmDetected.innerHTML = "Metamask connected to Ropsten"
                console.log("Metamask connected to Ropsten")
                setTimeout(function(){mmDetected.parentNode.removeChild(mmDetected)}, 3000)
            }

            else{
                mmDetected.innerHTML = "Wrong network, switch to Ropsten and try again"
                console.log("Wrong network, switch to Ropsten and try again")
            }
            
            
        }
    
    
    }
    else{
        let mmDetected = document.getElementById("mm-detected")
        mmDetected.innerHTML = "Metamask not detected, log in to Metamask and refresh"
        alert("Metamask not detected. Log in to Metamask and connect to Ropsten, then refresh")
        const mmConnect = document.getElementById("mm-connect")
        mmConnect.parentNode.removeChild(mmConnect)
    }
})