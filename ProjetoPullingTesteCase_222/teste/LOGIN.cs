using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace teste
{
    #region [: Login - Transporte de dados e rotinas :]


    public class LoginData
    {
        public string username { get; set; }
        public string password { get; set; }

        public LoginData()
        {
            username = string.Empty;
            password = string.Empty;
        }

        public static string ValidateLogin(string username, string password)
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
            catch (Exception oException)
            {
                //*** Trata erro de execução e retorna mensagem de erro
                return oException.Message;
            }
        }
    }

    #endregion
}