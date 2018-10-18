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
using System.Net.Mail;

namespace teste
{
    public partial class lostpassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string ValidateUser(string username, string email)
        {
            try
            {
                //*** Prepara objetos e abre conexão
                string ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
                SqlConnection oConnection = new SqlConnection(ConnectionString);
                oConnection.Open();

                //*** Cria adaptador e datatable usado na consulta
                SqlDataAdapter oAdapter = new SqlDataAdapter("", oConnection);
                DataTable oTable = new DataTable();

                //*** Localiza conjunto usuário/email na tabela respectiva
                string SQL = "SELECT * FROM dbo.users WHERE username = '" + username + "' AND email = '" + email + "'";
                oAdapter.SelectCommand.CommandText = SQL;
                oAdapter.Fill(oTable);

                //*** O usuário foi localizado com o email especificado?
                if (oTable.Rows.Count == 1)
                {
                    //*** Envia e-mail para usuário
                    MailMessage objMessage = new MailMessage(
                        "Diones Bandeira<dionesbandeira@gmail.com>",
                        oTable.Rows[0]["firstname"] + "<" + email + ">",
                        "Pulling TestCase - Password Recovery",
                        "Pulling TestCase - Password Recovery\r\n" +
                        "Your password is: " + oTable.Rows[0]["password"]);
                    SmtpClient SMTPServer = new SmtpClient();
                    SMTPServer.Port = 587;
                    SMTPServer.Host = "smtp.gmail.com";
                    SMTPServer.EnableSsl = true;
                    SMTPServer.Timeout = 50000;
                    SMTPServer.DeliveryMethod = SmtpDeliveryMethod.Network;
                    SMTPServer.UseDefaultCredentials = false;
                    SMTPServer.Credentials = new System.Net.NetworkCredential("dionesbandeira@gmail.com", "bahia5988");
                    SMTPServer.Send(objMessage);

                    //*** Retorna Ok
                    return "Ok";
                }
                else
                {
                    //*** Não localizado, retorna erro para popup
                    return "Username and Email does not exists.";
                }
            }
            catch (Exception oException)
            {
                //*** Trata erro de execução e retorna mensagem de erro
                return oException.Message;
            }
        }
    }
}