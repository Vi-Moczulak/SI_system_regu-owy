import javax.swing.*; 
import javax.swing.border.*; 
import javax.swing.table.*;
import java.awt.*; 
import java.awt.event.*; 

import java.text.BreakIterator;

import java.util.Locale;
import java.util.ResourceBundle;
import java.util.MissingResourceException;
 
import CLIPSJNI.*;


class Photography implements ActionListener
  {  
   JLabel displayLabel;
   JButton nextButton;
   JButton prevButton;
   JPanel choicesPanel;
   ButtonGroup choicesButtons;
   ResourceBundle photographyResources;
 
   Environment clips;
   boolean isExecuting = false;
   Thread executionThread;
      
   Photography()
     {  
      try
        {
         photographyResources = ResourceBundle.getBundle("resources.photographyResources",Locale.getDefault());
        }
      catch (MissingResourceException mre)
        {
         mre.printStackTrace();
         return;
        }
      
     
      JFrame jfrm = new JFrame(photographyResources.getString("Photography"));  
      jfrm.getContentPane().setLayout(new GridLayout(3,1));  
      jfrm.setSize(370,200);  
      jfrm.setLocation(500,250);
      jfrm.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);  
 

      JPanel displayPanel = new JPanel(); 
      displayLabel = new JLabel();
      displayPanel.add(displayLabel);
      choicesPanel = new JPanel(); 
      choicesButtons = new ButtonGroup();
      
      JPanel buttonPanel = new JPanel(); 
      
      prevButton = new JButton(photographyResources.getString("Prev"));
      prevButton.setActionCommand("Prev");
      buttonPanel.add(prevButton);
      prevButton.addActionListener(this);
      
      nextButton = new JButton(photographyResources.getString("Next"));
      nextButton.setActionCommand("Next");
      buttonPanel.add(nextButton);
      nextButton.addActionListener(this);
     

      jfrm.getContentPane().add(displayPanel); 
      jfrm.getContentPane().add(choicesPanel); 
      jfrm.getContentPane().add(buttonPanel); 

      
      clips = new Environment();
      
      clips.load("photography.clp");
      
      clips.reset();
      runphotography();

      jfrm.setVisible(true);  
     }  

   private void nextUIState() throws Exception
     {

      
      String evalStr = "(find-all-facts ((?f state-list)) TRUE)";
      
      String currentID = clips.eval(evalStr).get(0).getFactSlot("current").toString();

      
      evalStr = "(find-all-facts ((?f UI-state)) " +
                                "(eq ?f:id " + currentID + "))";
      
      PrimitiveValue fv = clips.eval(evalStr).get(0);

      
      if (fv.getFactSlot("state").toString().equals("final"))
        { 
         nextButton.setActionCommand("Restart");
         nextButton.setText(photographyResources.getString("Restart")); 
         prevButton.setVisible(true);
        }
      else if (fv.getFactSlot("state").toString().equals("initial"))
        {
         nextButton.setActionCommand("Next");
         nextButton.setText(photographyResources.getString("Start"));
         prevButton.setVisible(false);
        }
      else
        { 
         nextButton.setActionCommand("Next");
         nextButton.setText(photographyResources.getString("Next"));
         prevButton.setVisible(true);
        }
      
      choicesPanel.removeAll();
      choicesButtons = new ButtonGroup();
            
      PrimitiveValue pv = fv.getFactSlot("valid-answers");
      
      String selected = fv.getFactSlot("response").toString();
     
      for (int i = 0; i < pv.size(); i++) 
        {
         PrimitiveValue bv = pv.get(i);
         JRadioButton rButton;
                        
         if (bv.toString().equals(selected))
            { rButton = new JRadioButton(photographyResources.getString(bv.toString()),true); }
         else
            { rButton = new JRadioButton(photographyResources.getString(bv.toString()),false); }
                     
         rButton.setActionCommand(bv.toString());
         choicesPanel.add(rButton);
         choicesButtons.add(rButton);
        }
        
      choicesPanel.repaint();
      
 
      String theText = photographyResources.getString(fv.getFactSlot("display").symbolValue());
            
      wrapLabelText(displayLabel,theText);
      
      executionThread = null;
      
      isExecuting = false;
     }

 
   public void actionPerformed(
     ActionEvent ae) 
     { 
      try
        { onActionPerformed(ae); }
      catch (Exception e)
        { e.printStackTrace(); }
     }
 
 
   public void runphotography()
     {
      Runnable runThread = 
         new Runnable()
           {
            public void run()
              {
               clips.run();
               
               SwingUtilities.invokeLater(
                  new Runnable()
                    {
                     public void run()
                       {
                        try 
                          { nextUIState(); }
                        catch (Exception e)
                          { e.printStackTrace(); }
                       }
                    });
              }
           };
      
      isExecuting = true;
      
      executionThread = new Thread(runThread);
      
      executionThread.start();
     }

   public void onActionPerformed(
     ActionEvent ae) throws Exception 
     { 
      if (isExecuting) return;

      String evalStr = "(find-all-facts ((?f state-list)) TRUE)";
      
      String currentID = clips.eval(evalStr).get(0).getFactSlot("current").toString();


      if (ae.getActionCommand().equals("Next"))
        {
         if (choicesButtons.getButtonCount() == 0)
           { clips.assertString("(next " + currentID + ")"); }
         else
           {
            clips.assertString("(next " + currentID + " " +
                               choicesButtons.getSelection().getActionCommand() + 
                               ")");
           }
           
         runphotography();
        }
      else if (ae.getActionCommand().equals("Restart"))
        { 
         clips.reset(); 
         runphotography();
        }
      else if (ae.getActionCommand().equals("Prev"))
        {
         clips.assertString("(prev " + currentID + ")");
         runphotography();
        }
     }
 
   private void wrapLabelText(
     JLabel label, 
     String text) 
     {
      FontMetrics fm = label.getFontMetrics(label.getFont());
      Container container = label.getParent();
      int containerWidth = container.getWidth();
      int textWidth = SwingUtilities.computeStringWidth(fm,text);
      int desiredWidth;

      if (textWidth <= containerWidth)
        { desiredWidth = containerWidth; }
      else
        { 
         int lines = (int) ((textWidth + containerWidth) / containerWidth);
                  
         desiredWidth = (int) (textWidth / lines);
        }
                 
      BreakIterator boundary = BreakIterator.getWordInstance();
      boundary.setText(text);
   
      StringBuffer trial = new StringBuffer();
      StringBuffer real = new StringBuffer("<html><center>");
   
      int start = boundary.first();
      for (int end = boundary.next(); end != BreakIterator.DONE;
           start = end, end = boundary.next())
        {
         String word = text.substring(start,end);
         trial.append(word);
         int trialWidth = SwingUtilities.computeStringWidth(fm,trial.toString());
         if (trialWidth > containerWidth) 
           {
            trial = new StringBuffer(word);
            real.append("<br>");
            real.append(word);
           }
         else if (trialWidth > desiredWidth)
           {
            trial = new StringBuffer("");
            real.append(word);
            real.append("<br>");
           }
         else
           { real.append(word); }
        }
   
      real.append("</html>");
   
      label.setText(real.toString());
     }
     
   public static void main(String args[])
     {  
       
      SwingUtilities.invokeLater(
        new Runnable() 
          {  
           public void run() { new Photography(); }  
          });   
     }  
  }