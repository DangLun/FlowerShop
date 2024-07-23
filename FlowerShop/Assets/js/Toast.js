export function toast({ title = '', type = 'success', message = '' }) {
    const main = document.getElementById("toast");
    if (main) {
        const toast = document.createElement("div");

        // Auto remove toast
        const autoRemoveId = setTimeout(function () {
            main.removeChild(toast);
        }, 4000);

        // Remove toast when clicked
        toast.onclick = function (e) {
            if (e.target.closest(".toast-close")) {
                main.removeChild(toast);
                clearTimeout(autoRemoveId);
            }
        };

        let icons = {
            ['success']: '<i class="fa-solid fa-circle-check"></i>',
            ['error']: '<i class="fa-solid fa-circle-xmark"></i>',
            ['warning']: '<i class="fa-solid fa-triangle-exclamation"></i>',
            ['info']: '<i class="bi bi-exclamation-circle-fill"></i>'
        }

        let iconType = icons[type];
        const delay = 3;

        toast.classList.add("Toast", `toast--${type}`);
        toast.style.animation = `slideInLeft ease .4s, fadeOut linear 1s ${delay}s forwards`;

        toast.innerHTML = `
                        <div class="toast-icon">
                            ${iconType}
                        </div>
                        <div class="toast-body">
                            <h3 class="toast-title">${title}</h3>
                            <p class="toast-msg">${message}</p>
                        </div>
                        <div class="toast-close">
                            <i class="fas fa-times"></i>
                        </div>
                    `;
        main.appendChild(toast);
    }
}

export default toast;