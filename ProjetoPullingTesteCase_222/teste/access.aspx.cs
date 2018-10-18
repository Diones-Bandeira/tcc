using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace teste
{
    public partial class access : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //*** Coleta dados postados
            string username = Request.Form["username"];
            string password = Request.Form["password"];
            string remember = Request.Form["remember"];

            //*** os dados de login são válidos?
            if (LoginData.ValidateLogin(username, password) == "Ok")
            {
                //*** Salva cookie se solicitado
                if (remember == "true")
                {
                    //*** Declara cookie managaer
                    HttpCookie objCookieManager = new HttpCookie("PullingTesteCase");

                    //*** Define valor do cookie
                    objCookieManager.Value = username + "|" + password;

                    //*** Expira em uma semana
                    objCookieManager.Expires = DateTime.Now.AddDays(7);

                    //*** Salva cookie
                    Response.Cookies.Add(objCookieManager);
                }

                //*** Cria dados de login em sessão
                LoginData oLogin = new LoginData();
                oLogin.username = username;
                oLogin.password = password;
                Session["PullingTesteCase_Login"] = oLogin;

                //*** Abre tela inicial do sistema
                Response.Redirect("project.aspx");
            }
            else
            {
                //*** Rediciona ao formulário de login
                Response.Redirect("login.aspx");
            }
        }
    }
}