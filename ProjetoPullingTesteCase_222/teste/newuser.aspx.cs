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

namespace teste
{
    public partial class newuser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string ValidadeLogin(string username)
        {
            try
            {
                //*** Abre conexão com o banco de dados
                string ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
                SqlConnection oConnection = new SqlConnection(ConnectionString);
                oConnection.Open();

                //*** Cria adaptador e datatable
                SqlDataAdapter oAdapter = new SqlDataAdapter("", oConnection);
                DataTable oTable = new DataTable();

                //*** Busca USERNAME duplicado
                string SQL = "SELECT * FROM dbo.users WHERE username = '" + username + "'";
                oAdapter.SelectCommand.CommandText = SQL;
                oAdapter.Fill(oTable);

                //*** Há login duplicado?
                if (oTable.Rows.Count == 0)
                {
                    //*** Não. Pode cadastrar.
                    return "Ok";
                }
                else
                {
                    //*** Sim. Proibe duplicidade
                    return "Exists";
                }
            }
            catch (Exception oException)
            {
                //*** Retorna mensagem de erro
                return oException.Message;
            }
        }

        [WebMethod]
        public static string CreateUser(string username, string firstname, string email,
                                        string password, string position, string experiece)
        {
            try
            {
                //*** Abre conexão com o banco de dados
                string ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();

                //*** Cria adaptador e datatable
                SqlDataAdapter oAdapter = new SqlDataAdapter();

                //*** Cria comando de inclusão
                string SQL = "INSERT INTO dbo.users (";
                SQL += "username,";
                SQL += "firstname,";
                SQL += "email,";
                SQL += "password,";
                SQL += "position,";
                SQL += "timeexperience";
                SQL += ") VALUES (";
                SQL += "'" + username + "',";
                SQL += "'" + firstname + "',";
                SQL += "'" + email + "',";
                SQL += "'" + password + "',";
                SQL += "'" + position + "',";
                SQL += "'" + experiece + "')";

                //*** Inicaliza comando de update
                oAdapter.UpdateCommand = new SqlCommand(SQL, new SqlConnection(ConnectionString));
                oAdapter.UpdateCommand.Connection.Open();
                
                //*** Realiza inserção
                oAdapter.UpdateCommand.ExecuteNonQuery();

                //*** Cadastro bem sucedido
                return "Ok";
            }
            catch (Exception oException)
            {
                return oException.Message;
            }
        }
    }
}