using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace teste
{
    public partial class signout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //*** Derruba sessão atual;
            Session["PullingTesteCase_Login"] = null;

            //*** Remove cookie de login
            HttpCookie oCookie = new HttpCookie("PullingTesteCase");
            oCookie.Expires = DateTime.Now.AddDays(-1d);
            Response.Cookies.Add(oCookie);

            //*** Redireciona ao login
            Response.Redirect("login.aspx");
        }
    }
}