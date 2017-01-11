using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MASTERSEGUROS.WEB
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        public string  getApolices()
        {
            string rdr = string.Empty;

            using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            {
                //Fill all Periods/Years
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(APOLICEID) FROM master_apolice_auto", con))
                {
                    cmd.CommandType = System.Data.CommandType.Text;

                    con.Open();
                    rdr = cmd.ExecuteScalar().ToString();
                  
                    con.Close();
                }
            }

            return rdr;
        }

        public string getAvisosPagamento()
        {
            string mstr = string.Empty;

            using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            {
                //Avisos em Pagamento
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(ApoliceAvisoCobrancaID) FROM  master_apolice_auto_aviso_cobranca where estado=1", con))
                {
                    cmd.CommandType = System.Data.CommandType.Text;

                    con.Open();
                    mstr = cmd.ExecuteScalar().ToString();

                    con.Close();
                }
            }

            return mstr;
        }

        public string getCountClientes()
        {
            string rdr = string.Empty;

            using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            {
                //Fill all Periods/Years
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(ClienteID) FROM master_cliente", con))
                {
                    cmd.CommandType = System.Data.CommandType.Text;

                    con.Open();
                    rdr = cmd.ExecuteScalar().ToString();

                    con.Close();
                }
            }

            return rdr;
        }

        public string GetPagamentosDia()
        {

            DateTime minhaData = DateTime.Now;
            string minhaDataFormatada = minhaData.ToString("yyyy-MM-dd");

            string retorno = String.Empty;

            using (SqlConnection con = new SqlConnection(MASTERSEGUROS.WEB.Comum.General.getConnection()))
            {

                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(PagamentoID) FROM master_apolice_pagamento where cast(DataCriacao as date) = cast('" + minhaDataFormatada + "' as date) ", con))
                {
                    cmd.CommandType = System.Data.CommandType.Text;

                    con.Open();

                    retorno = cmd.ExecuteScalar().ToString();

                    con.Close();
                }
            }

            return retorno;
        }
    }
}
