document.addEventListener("keydown", function(event) {
    if (event.key === "Escape") {
        window.postMessage({ action: "closeSmooth" }, "*");
    }
});

window.addEventListener("message", function(event) {
    const TeleportWindow = document.getElementById("tp-window");

    if (event.data.action === "open") {
        TeleportWindow.style.display = "flex";
        setTimeout(() => {
            TeleportWindow.classList.add("show");
        }, 10);
    } else if (event.data.action === "closeSmooth") {
        TeleportWindow.classList.remove("show");
        setTimeout(() => {
            TeleportWindow.style.display = "none";
            fetch(`https://${GetParentResourceName()}/closeUI`, { 
                method: "POST", 
                headers: { "Content-Type": "application/json" }, 
                body: "{}" 
            });
        }, 300);
    }
});

document.querySelectorAll(".tp-btn").forEach((button, index) => {
    button.addEventListener("click", () => {
        fetch(`https://${GetParentResourceName()}/teleportPlayer`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ location: `location${index + 1}` })
        });
    });
});

document.querySelector(".close-btn").addEventListener("click", function() {
    window.postMessage({ action: "closeSmooth" }, "*");
});
