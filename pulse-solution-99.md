import React, { useState, useEffect } from 'react';
import { FileText, Layers, MousePointer2, Save, Share2, Plus, Trash2 } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';

// Tipagem do Sistema
type ElementType = 'text' | 'image' | 'shape';

interface FlowElement {
  id: string;
  type: ElementType;
  content: string;
  x: number;
  y: number;
}

export default function A4Flow() {
  const [elements, setElements] = useState<FlowElement[]>([]);
  const [isSaving, setIsSaving] = useState(false);

  // Adicionar novo elemento ao fluxo
  const addElement = (type: ElementType) => {
    const newElement: FlowElement = {
      id: Math.random().toString(36).substr(2, 9),
      type,
      content: type === 'text' ? 'Novo Texto' : '',
      x: 50,
      y: 50,
    };
    setElements([...elements, newElement]);
  };

  const saveProgress = () => {
    setIsSaving(true);
    setTimeout(() => setIsSaving(false), 1500);
  };

  return (
    <div className="min-h-screen bg-slate-900 text-slate-100 flex flex-col font-sans">
      {/* HEADER */}
      <header className="h-16 border-b border-slate-800 bg-slate-900/50 backdrop-blur-md flex items-center justify-between px-6 sticky top-0 z-50">
        <div className="flex items-center gap-3">
          <div className="bg-blue-600 p-2 rounded-lg">
            <FileText size={20} className="text-white" />
          </div>
          <h1 className="font-bold tracking-tight text-lg">A4-FLOW <span className="text-blue-500 text-xs font-mono">v2.0</span></h1>
        </div>

        <div className="flex items-center gap-4">
          <button 
            onClick={saveProgress}
            className="flex items-center gap-2 bg-slate-800 hover:bg-slate-700 px-4 py-2 rounded-full transition-all text-sm font-medium"
          >
            {isSaving ? <div className="w-4 h-4 border-2 border-blue-500 border-t-transparent animate-spin rounded-full" /> : <Save size={16} />}
            {isSaving ? 'Salvando...' : 'Salvar'}
          </button>
          <button className="bg-blue-600 hover:bg-blue-500 px-4 py-2 rounded-full transition-all text-sm font-bold shadow-lg shadow-blue-900/20 flex items-center gap-2">
            <Share2 size={16} />
            Exportar
          </button>
        </div>
      </header>

      <main className="flex-1 flex overflow-hidden">
        {/* TOOLBAR ESQUERDA */}
        <aside className="w-20 border-r border-slate-800 flex flex-col items-center py-8 gap-6 bg-slate-900/30">
          <button onClick={() => addElement('text')} className="p-3 rounded-xl bg-slate-800 hover:bg-blue-600/20 hover:text-blue-400 transition-all group">
            <Layers size={24} />
            <span className="absolute left-24 bg-slate-800 text-xs px-2 py-1 rounded opacity-0 group-hover:opacity-100 pointer-events-none transition-opacity">Blocos</span>
          </button>
          <button className="p-3 rounded-xl bg-slate-800 hover:bg-blue-600/20 hover:text-blue-400 transition-all">
            <MousePointer2 size={24} />
          </button>
          <div className="h-px w-8 bg-slate-800" />
          <button onClick={() => addElement('text')} className="p-3 rounded-xl bg-blue-600 hover:bg-blue-500 transition-all shadow-lg shadow-blue-900/40">
            <Plus size={24} />
          </button>
        </aside>

        {/* CANVAS DE EDIÇÃO */}
        <section className="flex-1 bg-slate-950 overflow-auto p-4 md:p-12 flex justify-center items-start">
          {/* FOLHA A4 RESPONSIVA */}
          <motion.div 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="relative bg-white shadow-2xl w-full max-w-[210mm] aspect-[1/1.414] origin-top transform scale-[0.95] md:scale-100 rounded-sm"
          >
            {/* Grid de Background */}
            <div className="absolute inset-0 opacity-[0.03] pointer-events-none" 
                 style={{ backgroundImage: 'radial-gradient(#000 1px, transparent 1px)', backgroundSize: '20px 20px' }} />
            
            <div className="p-12">
               {elements.length === 0 && (
                 <div className="h-full flex flex-col items-center justify-center border-2 border-dashed border-slate-200 rounded-xl min-h-[400px]">
                    <p className="text-slate-400 text-sm">Comece a desenhar seu fluxo aqui</p>
                 </div>
               )}

               <AnimatePresence>
                 {elements.map((el) => (
                   <motion.div
                     key={el.id}
                     initial={{ scale: 0.8, opacity: 0 }}
                     animate={{ scale: 1, opacity: 1 }}
                     exit={{ scale: 0.8, opacity: 0 }}
                     drag
                     dragConstraints={{ top: 0, left: 0, right: 0, bottom: 0 }}
                     className="absolute cursor-move p-4 bg-blue-50 border border-blue-200 rounded-lg text-slate-900 shadow-sm"
                   >
                     <div className="flex items-center gap-4">
                        <span className="font-medium">{el.content}</span>
                        <button 
                          onClick={() => setElements(prev => prev.filter(item => item.id !== el.id))}
                          className="text-red-400 hover:text-red-600 transition-colors"
                        >
                          <Trash2 size={14} />
                        </button>
                     </div>
                   </motion.div>
                 ))}
               </AnimatePresence>
            </div>
          </motion.div>
        </section>

        {/* PAINEL DE PROPRIEDADES DIREITA (Visível apenas em Desktop) */}
        <aside className="hidden lg:flex w-72 border-l border-slate-800 flex-col p-6 bg-slate-900/30">
          <h3 className="text-xs font-bold uppercase tracking-widest text-slate-500 mb-6">Propriedades</h3>
          
          <div className="space-y-6">
            <div className="space-y-2">
              <label className="text-sm text-slate-400">Nome do Documento</label>
              <input type="text" defaultValue="Fluxo de Onboarding" className="w-full bg-slate-800 border border-slate-700 rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500 outline-none transition-all" />
            </div>

            <div className="p-4 rounded-xl bg-blue-600/10 border border-blue-600/20">
              <p className="text-xs text-blue-400 leading-relaxed">
                O modo de visualização A4 garante que sua exportação PDF manterá a proporção exata de impressão.
              </p>
            </div>
          </div>
        </aside>
      </main>
    </div>
  );
}
