import { initializeApp } from "https://www.gstatic.com/firebasejs/10.12.0/firebase-app.js";
import { getFirestore, getCountFromServer, collection, query, where } from "https://www.gstatic.com/firebasejs/10.12.0/firebase-firestore.js";

const cfg = window.FIREBASE_CONFIG || {};

function get(id) {
  return document.getElementById(id);
}

function showErr(id, msg) {
  const el = get(id);
  if (el) el.textContent = msg;
}

let db = null;
try{
  if (cfg.apiKey && cfg.authDomain && cfg.projectId){
    const app = initializeApp(cfg);
    db = getFirestore(app);
  }
}catch(_){}

const goDashboard = () => {
  window.location.href = "/dashboard";
};

get("emailLoginBtn").onclick = async () => {
  showErr("emailErr", "");
  get("emailLoading").textContent = "Loading…";
  const name = (get("name")?.value || "").trim();
  const email = (get("email")?.value || "").trim();
  const phone = (get("phone")?.value || "").trim();
  if (!email){
    showErr("emailErr","Enter email");
    get("emailLoading").textContent = "";
    return;
  }
  try{
    const resp = await fetch("/api/simple_login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ name, email, phone })
    });
    const j = await resp.json().catch(()=>({}));
    if (resp.ok && j.ok) {
      window.location.href = "/";
    } else {
      showErr("emailErr","Please retry");
    }
  }catch(_){
    showErr("emailErr","Please retry");
  }
  get("emailLoading").textContent = "";
};

async function refreshCounters() {
  if (!db) return;
  try {
    const total = await getCountFromServer(collection(db, "users"));
    const active = await getCountFromServer(
      query(collection(db, "users"), where("isOnline", "==", true))
    );
    const tEl = get("totalUsers");
    const aEl = get("activeUsers");
    if (tEl) tEl.textContent = total.data().count;
    if (aEl) aEl.textContent = active.data().count;
  } catch (e) {}
}

setInterval(refreshCounters, 10000);
refreshCounters();
