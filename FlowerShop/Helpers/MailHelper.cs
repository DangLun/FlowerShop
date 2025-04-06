using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Threading.Tasks;
using System.Web;

namespace FlowerShop.Helpers
{
    public class MailHelper
    {
        public void SendEmail(string recipientEmail, string subject, string Message)
        {
            SmtpClient client = new SmtpClient("smtp.gmail.com", 587)
            {
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential("danglun337747@gmail.com", "your password gmail"),
                EnableSsl = true
            };

            var mailMessage = new MailMessage
            {
                From = new MailAddress("danglun337747@gmail.com"),
                Subject = subject,
                Body = Message,
                IsBodyHtml = true,
            };

            mailMessage.To.Add(recipientEmail);

            client.Send(mailMessage);
        }
    }
}