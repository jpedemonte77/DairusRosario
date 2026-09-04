# Carta digital para el bar

Dos páginas y una base de datos gratuita. Nada más.

| Archivo | Qué es | Quién lo usa |
|---|---|---|
| `index.html` | La carta que ven los clientes | Cualquiera con el enlace o el QR. **Sólo mira, no puede editar.** |
| `admin.html` | El panel para editar | Sólo vos, con email y contraseña |
| `supabase.sql` | La estructura de la base de datos | Se pega una sola vez, al principio |

**Costo total: $0.** El plan gratuito de Supabase y el de Netlify alcanzan de sobra para la carta de un bar.

---

## Puesta en marcha (unos 20 minutos, una sola vez)

### 1. Crear la base de datos

1. Entrá a **[supabase.com](https://supabase.com)** → *Start your project* → creá la cuenta (podés usar Google).
2. **New project**. Ponele un nombre (ej. `carta-bar`), elegí una contraseña para la base y la región **South America (São Paulo)**. Guardá esa contraseña por las dudas.
3. Esperá 1-2 minutos a que el proyecto termine de crearse.

### 2. Crear las tablas

1. En el menú de la izquierda: **SQL Editor** → *New query*.
2. Abrí el archivo `supabase.sql` con cualquier editor de texto, copiá **todo** el contenido y pegalo ahí.
3. Botón **Run** (o Ctrl+Enter). Tiene que decir *Success*.

Esto crea las tablas, deja la carta abierta para lectura, cierra la edición a quien no tenga cuenta, y carga unos productos de ejemplo para que veas cómo queda.

### 3. Copiar las dos claves

1. **Project Settings** (el engranaje, abajo a la izquierda) → **API Keys** (o *Data API*).
2. Copiá estos dos valores:
   - **Project URL** → algo como `https://abcdefgh.supabase.co`   
   - **anon public** → una clave larga que empieza con `eyJ...`

> La clave `anon` es pública a propósito: está pensada para vivir dentro de la página. Sirve **solo para leer** la carta. La que nunca hay que compartir es la `service_role`.

### 4. Pegarlas en los dos archivos

Abrí `index.html` y `admin.html` con el Bloc de notas (o TextEdit) y buscá, cerca del final, este bloque:

```js
const CONFIG = {
  SUPABASE_URL: "",
  SUPABASE_ANON_KEY: ""
};
```

Completalo con tus datos, **en los dos archivos**:

```js
const CONFIG = {
  SUPABASE_URL: "https://abcdefgh.supabase.co",
  SUPABASE_ANON_KEY: "eyJhbGciOi..."
};
```

Guardá. Si abrís `index.html` haciendo doble clic, ya deberías ver la carta de ejemplo.

### 5. Crear tu usuario de administrador

1. En Supabase: **Authentication** → **Users** → **Add user** → *Create new user*.
2. Poné tu email y una contraseña. **Marcá "Auto Confirm User"** para no tener que validar el mail.

### 6. Cerrar la puerta (importante ⚠️)

1. **Authentication** → **Sign In / Providers** → **Email**.
2. **Desactivá "Allow new users to sign up"** y guardá.

Sin esto, cualquiera podría crearse una cuenta y editar tu carta. Con esto, el único que puede entrar sos vos.

### 7. Subirlo a internet

La opción más simple, sin instalar nada:

1. Poné `index.html` y `admin.html` juntos en una carpeta (el `.sql` y este `LEEME` no hace falta subirlos).
2. Entrá a **[app.netlify.com/drop](https://app.netlify.com/drop)** y **arrastrá la carpeta** a la ventana.
3. Creá la cuenta gratuita cuando te la pida (así el sitio queda guardado y no se borra).
4. En **Site configuration → Change site name**, elegí un nombre lindo: te queda `https://elnombrequeelijas.netlify.app`.

Alternativas equivalentes: **Vercel** o **Cloudflare Pages**. Todas gratis.

### 8. Cargar la carta de verdad

1. Entrá a `https://tusitio.netlify.app/admin.html`
2. Ingresá con el email y la contraseña del paso 5.
3. **Pestaña Carta:** borrá los ejemplos y cargá tus secciones y productos.
4. **Pestaña Diseño:** nombre del bar, foto de fondo, logo, color, pie de página.
5. **Pestaña QR y enlace:** generá el QR, descargalo o imprimí el cartelito para las mesas.

Listo. Cada cambio que guardes se ve al instante en el celular del cliente.

---

## El día a día

- **Cambiar un precio:** entrás a `/admin.html`, Editar, escribís el número nuevo, Guardar. Tarda 10 segundos y se puede hacer desde el celular.
- **Se acabó algo:** botón **Ocultar**. Desaparece de la carta pero no se borra; cuando vuelve, **Mostrar**.
- **Reordenar:** las flechas ↑ ↓ de cada sección y de cada producto.
- **Cambiar la foto de fondo:** pestaña Diseño → Imagen de fondo. Achicá la foto a menos de 1 MB (por ejemplo en [squoosh.app](https://squoosh.app)) para que la carta cargue rápido con el wifi del bar.

---

## Preguntas que suelen aparecer

**¿Un cliente puede editar la carta?**
No. La página pública sólo puede leer; la base de datos rechaza cualquier intento de escritura sin haber iniciado sesión. Aunque alguien abra `/admin.html`, sin tu email y contraseña no pasa del login.

**¿Y si alguien ve la clave en el código?**
No pasa nada: la clave `anon` sólo habilita lo mismo que ya hace la carta, leer. Los permisos están puestos en la base (RLS), no en la página.

**¿Cuántas visitas aguanta?**
El plan gratuito de Supabase da 5 GB de tráfico por mes; la carta pesa unos pocos KB por visita más la imagen de fondo. Para un bar sobra ampliamente. Netlify da 100 GB.

**El QR ya está impreso y quiero cambiar la carta.**
No hace falta reimprimir nada: el QR apunta a la dirección, y el contenido detrás de esa dirección lo cambiás cuando quieras.

**¿Puedo tener mi propio dominio?**
Sí. Comprás uno (`.com.ar` en [nic.ar](https://nic.ar), o `.com` en Namecheap / Cloudflare) y lo conectás en Netlify → *Domain management*. La carta y el QR siguen funcionando igual, sólo cambia la dirección.

**¿Y si el proyecto de Supabase se pausa?**
El plan gratuito pausa los proyectos que no reciben tráfico durante una semana. Con clientes escaneando el QR eso no pasa; si igual llegara a ocurrir, se reactiva con un clic desde el panel de Supabase.

**Quiero que otra persona (encargado, barman) también pueda editar.**
Creale un usuario más en Supabase → Authentication → Users → Add user. Tiene los mismos permisos que vos.

---

## Si algo no anda

| Síntoma | Causa casi segura |
|---|---|
| La carta muestra los productos de ejemplo | Falta pegar la URL y la clave en `index.html` |
| "Email o contraseña incorrectos" | El usuario no se creó con *Auto Confirm User* |
| No puedo guardar cambios en el panel | La sesión venció: salí y volvé a entrar |
| La imagen de fondo no aparece | El bucket `carta` no quedó público — volvé a correr el `supabase.sql` |
| Todo en blanco | Abrí la consola del navegador (F12) y mirá el error en rojo |
