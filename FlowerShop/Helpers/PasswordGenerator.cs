using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.Helpers
{
    public class PasswordGenerator
    {
        private static readonly Random random = new Random();
        private const string Lowercase = "abcdefghijklmnopqrstuvwxyz";
        private const string Uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        private const string Digits = "0123456789";
        private const string SpecialCharacters = "!@#$%^&*()_+[]{}|;:,.<>?";

        public string GenerateStrongPassword(int length = 8)
        {
            if (length < 8)
            {
                throw new ArgumentException("Password length should be at least 8 characters.");
            }

            char[] password = new char[length];
            password[0] = Lowercase[random.Next(Lowercase.Length)];
            password[1] = Uppercase[random.Next(Uppercase.Length)];
            password[2] = Digits[random.Next(Digits.Length)];
            password[3] = SpecialCharacters[random.Next(SpecialCharacters.Length)];

            string allCharacters = Lowercase + Uppercase + Digits + SpecialCharacters;

            for (int i = 4; i < length; i++)
            {
                password[i] = allCharacters[random.Next(allCharacters.Length)];
            }

            return new string(password.OrderBy(x => random.Next()).ToArray());
        }
    }
}