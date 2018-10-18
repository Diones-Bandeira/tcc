using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Text;

namespace teste
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie objCookie = Request.Cookies["PullingTesteCase"];

            // Read the cookie information and display it.
            if (objCookie != null)
            {
                //*** Obtem usuário e senha
                string[] logininfo = objCookie.Value.Split('|');

                //*** O cookie possui usuário e senha?
                if (logininfo.Length == 2)
                {
                    //*** Valida login
                    if (ValidateLogin(logininfo[0], logininfo[1], "false") == "Ok")
                    {
                        //*** Salva login em campos hidden
                        this.txtUser.Value = logininfo[0];
                        this.txtPass.Value = logininfo[1];
                    }
                }
            }
        }

        [WebMethod]
        public static string ValidateLogin(string username, string password, string remember)
        {
            try
            {
                //*** Prepara objetos e abre conexão
                string ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString() ;
                SqlConnection oConnection = new SqlConnection(ConnectionString);
                oConnection.Open();

                //*** Cria adaptador e datatable usado na consulta
                SqlDataAdapter oAdapter = new SqlDataAdapter("", oConnection);
                DataTable oTable = new DataTable();

                //*** Localiza conjunto usuário/senha na tabela respectiva
                string SQL = "SELECT * FROM dbo.users WHERE username = '" + username + "' AND password = '" + password + "'";
                oAdapter.SelectCommand.CommandText = SQL;
                oAdapter.Fill(oTable);

                //*** O usuário foi localizado com a senha especificada?
                if (oTable.Rows.Count == 1)
                {
                    //*** Retorna Ok
                    return "Ok";
                }
                else
                {
                    //*** Retorna mensagem de erro
                    return "User or password are incorrect.";
                }
            }
            catch(Exception oException)
            {
                //*** Trata erro de execução e retorna mensagem de erro
                return oException.Message;
            }
        }
    }
}