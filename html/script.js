document.addEventListener("keydown", function(event) {
    if (event.key === "Escape") {
        window.postMessage({ action: "closeSmooth" }, "*");
    }
});

window.addEventListener("message", function(event) {
    const TeleportWindow = document.getElementById("tp-window");
    const container = document.getElementById("tp-places-container");

    if (event.data.action === "open") {
        TeleportWindow.style.display = "flex";
        setTimeout(() => {
            TeleportWindow.classList.add("show");
        }, 10);

        container.innerHTML = '';

        event.data.locations.forEach((location, index) => {
            const placeDiv = document.createElement("div");
            placeDiv.classList.add("tp-place");

            const img = document.createElement("img");
            img.src = location.imgUrl;
            img.alt = location.name;

            const nameP = document.createElement("p");
            nameP.innerText = location.name;

            const btn = document.createElement("button");
            btn.classList.add("tp-btn");
            btn.innerText = "Teleport";

            btn.addEventListener("click", () => {
                fetch(`https://${GetParentResourceName()}/teleportPlayer`, {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ location: index + 1 })
                });
            });

            placeDiv.appendChild(img);
            placeDiv.appendChild(nameP);
            placeDiv.appendChild(btn);

            container.appendChild(placeDiv);
        });
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

document.querySelector(".close-btn").addEventListener("click", function() {
    window.postMessage({ action: "closeSmooth" }, "*");
});
