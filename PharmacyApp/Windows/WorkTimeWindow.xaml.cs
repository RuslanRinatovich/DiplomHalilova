﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using EduInstitutesApp.Models;
namespace EduInstitutesApp.Windows
{
    /// <summary>
    /// Логика взаимодействия для WorkTimeWindow.xaml
    /// </summary>
    public partial class WorkTimeWindow : Window
    {
        public WorkTime currentItem { get; private set; }
        public WorkTimeWindow(WorkTime p)
        {
            InitializeComponent();
            currentItem = p;
            this.DataContext = currentItem;
        }

        private void Accept_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = true;
        }
    }
}

